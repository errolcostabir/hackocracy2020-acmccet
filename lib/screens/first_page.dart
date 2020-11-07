import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
//create a list of posts from the database to display to users

  List<Posts> postsList = [];

//Method to get all posts from the database. Method is called in the inistate function

  getPosts() {
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      postsList.clear();
      for (var individualKey in KEYS) {
        Posts posts = new Posts(DATA[individualKey]['image'],
            DATA[individualKey]['description'], DATA[individualKey]['address']);
        postsList.add(posts);
      }
      setState(() {
        print('Length: $postsList.length');
      });
    });
  }

  @override
  void initState() {
    super.initState();

    //getposts is called here to get all posts on initialization of this widget

    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF049560),
        body: Container(
            child: postsList.length == 0
                ? new Text("No events")
                : new ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (_, index) {
                      return Doc(
                          postsList[index].image,
                          postsList[index].description,
                          postsList[index].address);
                    })));
  }
}

//posts class

class Posts {
  String image, description, address;
  Posts(this.image, this.description, this.address);
}


//Card Widget to display the Event set by user as a post to the rest of the users

Widget Doc(String image, String description, String address) {
  return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 20.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
                height: 20.0,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                    Text(
                      address ?? 'Address',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                )),
            SizedBox(
              height: 5.0,
            ),
            Container(
              child: Image.network(image),
              height: 200.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              description ?? 'Description',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                  child: RaisedButton(
                    child: Text('Attend Drive'),
                    onPressed: null,
                    color: Color(0xFF007ACC),
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
