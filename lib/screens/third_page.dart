import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'second_page.dart';

class ThirdPage extends StatefulWidget {
  final String email;
  final int points;

  ThirdPage({Key key, this.email, this.points}) : super(key: key);
  @override
  ThirdPageState createState() => ThirdPageState();
}

class ThirdPageState extends State<ThirdPage> {
  Future<File> file;
  String base64Image;
  File tmpFile;
  String caption;
  String url;
  String date;
  String email = '';
  int points;
  List _outputs;

//geolocator to find the current user location and add it automatically to the event that the user posts

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition;
  String currentAddress;

//method to call the system camera to click a photo

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

//method to begin uploading the picture to the firestore so that it shows up to all the users using this app

  startUpload() async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("Reports");
    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(await file);
    var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = ImageUrl.toString();
    print("Image Url: " + url);
    goToHomePage();
    saveToDatabase(url);
  }

//Upload to server the offences

  startUploadToReport() async {
    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("Offences");
    var timeKey = new DateTime.now();
    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".jpg").putFile(await file);
    goToHomePage();
  }

//method to go to home page after uploading the picture to firestore

  goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen(email, points);
    }));
  }

//method to save data to the database

  saveToDatabase(url) {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": caption,
      "date": date,
      "address": currentAddress,
    };
    ref.child("Posts").push().set(data);
  }

//widget that is used to show the preview of image before uploading

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print('inside showimage');
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

//method used to get the current location of user using the geolocator plugin

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

//method to get the exact address from the latitude and longitude

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
            "${place.locality}, ${place.postalCode} Lat: ${currentPosition.latitude} Long: ${currentPosition.longitude}";
        print(currentAddress);
      });
    } catch (e) {
      print(e); 
    }
  }

//method to load model

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/classifier.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

//method to clafiffy image

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _outputs = output;
      print(_outputs[0]['confidence']);
      if (_outputs[0]['confidence'] > 0.90) {
        print('entered if loop');
        startUploadToReport();
      } else {
        goToHomePage();
      }
    });
  }

  //method to run ml code to classify the image clicked and upload to database accordingly

  runMlCode() {
    loadModel().then((value) {});
    classifyImage(tmpFile);
  }

  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    chooseImage();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    //print('indeide buider\n');
    return Scaffold(
      backgroundColor: Color(0xFF049560),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  caption = value;
                },
                decoration: constant_textfield.copyWith(
                    hintText: 'Enter Description Of Event')),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  date = value;
                },
                decoration:
                    constant_textfield.copyWith(hintText: 'Enter Drive Date')),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Create Event'),
                  onPressed: startUpload,
                  color: Color(0xFF007ACC),
                ),
                SizedBox(
                  width: 20.0,
                ),
                RaisedButton(
                  onPressed: runMlCode,
                  child: Text('Report Issue'),
                  color: Color(0xFF007ACC),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
