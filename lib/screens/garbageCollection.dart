import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hackocracy/screens/awarenessPage.dart';

class GarbageCollectionMap extends StatefulWidget {
  @override
  _GarbageCollectionMapState createState() => _GarbageCollectionMapState();
}

class _GarbageCollectionMapState extends State<GarbageCollectionMap> {
  List<Marker> markers = [];

  setMarkers() {
    markers = [
      MyMarkers.createMarkers(15.2741926, 73.9566943),
      MyMarkers.createMarkers(15.27159, 73.962146),
      MyMarkers.createMarkers(15.280593, 73.989165),
      MyMarkers.createMarkers(15.294352, 73.974893),
      MyMarkers.createMarkers(15.295704, 73.956922),
      MyMarkers.createMarkers(15.28845, 73.963246),
      MyMarkers.createMarkers(15.2736, 73.952326),
      MyMarkers.createMarkers(15.27122, 73.955959),
      MyMarkers.createMarkers(15.289872, 73.969314),
      MyMarkers.createMarkers(15.296214, 73.952719),
    ];
    setState(() {});
  }

  loadMarkers() async {
    final response =
        await http.get('${ServerData.serverLoc}/getCollectionSpotData.php');

    var jsonData = json.decode(response.body);

    for (var data in jsonData) {
      print(data['Id']);
      markers.add(
        Marker(
          width: 25.0,
          height: 25.0,
          point: LatLng(
            double.parse(data['latitude']),
            double.parse(data['longitude']),
          ),
          builder: (ctx) => Container(
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = List<Marker>();
    setMarkers();
    // loadMarkers();
  }

  Widget showMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(MapData.latitude, MapData.longitude),
        zoom: MapData.mapZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: MapData.mapURL,
          // subdomains: MapData.subDomains,
        ),
        MarkerLayerOptions(
          markers: markers,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    setMarkers();
    return Scaffold(
      body: Container(
        child: markers.length == 0 ? CircularProgressIndicator() : showMap(),
      ),
    );
  }
}

class MyMarkers {
  static Marker createMarkers(double latitude, double longitude) {
    return Marker(
      width: 25.0,
      height: 25.0,
      point: LatLng(
        latitude,
        longitude,
      ),
      builder: (ctx) => Container(
        child: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
