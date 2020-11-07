import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:hackocracy/screens/awarenessPage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FootPrintMap extends StatefulWidget {
  @override
  _FootPrintMapState createState() => _FootPrintMapState();
}

class _FootPrintMapState extends State<FootPrintMap> {
  loadData() async {
    final response = await http.get(ServerData.carbonDataURL);
    var jsonData = response.body;
  }

  _generateData() {
    List<CO2Footprints> data = [
      CO2Footprints(co2Emission: 20010.345, year: 2000),
      CO2Footprints(co2Emission: 22345.53, year: 2001),
      CO2Footprints(co2Emission: 23234.644, year: 2002),
      CO2Footprints(co2Emission: 24767.56, year: 2003),
      CO2Footprints(co2Emission: 25456.293, year: 2004),
      CO2Footprints(co2Emission: 25789.345, year: 2005),
      CO2Footprints(co2Emission: 26594.384, year: 2006),
      CO2Footprints(co2Emission: 26984.43, year: 2007),
      CO2Footprints(co2Emission: 27278.9, year: 2008),
      CO2Footprints(co2Emission: 27605.785, year: 2009),
      CO2Footprints(co2Emission: 28432.748, year: 2010),
      CO2Footprints(co2Emission: 28943.273, year: 2011),
      CO2Footprints(co2Emission: 29533.734, year: 2012),
      CO2Footprints(co2Emission: 30690.783, year: 2013),
      CO2Footprints(co2Emission: 32274.679, year: 2014),
      CO2Footprints(co2Emission: 33834.253, year: 2015),
      CO2Footprints(co2Emission: 35726.538, year: 2016),
      CO2Footprints(co2Emission: 36045.824, year: 2017),
      CO2Footprints(co2Emission: 37438.235, year: 2018),
    ];

    setState(() {});
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    _generateData();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Expanded(
              child: SfCartesianChart(
                title: ChartTitle(
                  text: "CO2 Emission Data from 2000 to 2018",
                  textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                    text: "Years",
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    text: "Amount of CO2 Emissions",
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                series: <ChartSeries>[
                  ColumnSeries<CO2Footprints, String>(
                    dataSource: _generateData(),
                    xValueMapper: (CO2Footprints co2F, _) =>
                        co2F.year.toString(),
                    xAxisName: "Years",
                    yValueMapper: (CO2Footprints co2F, _) => co2F.co2Emission,
                    yAxisName: "Ammount of CO2 Emissions",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CO2Footprints {
  double co2Emission;
  int year;
  CO2Footprints({this.co2Emission, this.year});
}
