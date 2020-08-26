import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/screens/home.dart';
import 'package:think_tank/model/model.dart';
import 'package:think_tank/util/constants.dart';

class Login extends StatefulWidget {
  Login();
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Firestore firestore;

  CollectionReference get users => firestore.collection('users');

  Future<List<DocumentSnapshot>> _getUsers() async {
    firestore = Firestore(app: await getFirebaseApp());
    QuerySnapshot snapshot = await users.getDocuments();
    return snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _mainHeader(context),
          _selector(),
          _bodyContent(),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
    ));
  }

  Widget _mainHeader(context) {
    final size = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          height: 250,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.teal[100],
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0)),
            child: Image.asset(
              'data/images/logo.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _selector() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Text("SELECT PROFILE ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, fontFamily: 'nunito')),
    );
  }

  Widget _bodyContent() {
    return Expanded(
      flex: 1,
      child: FutureBuilder(
          initialData: null,
          future: _getUsers(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            Widget _body;
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                _body = Center(
                    child: Text(
                        "SOMETHING WENT TOTALLY WRONG CONTACT DEVELOPER!!!"));
              } else {
                _body = ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      // print(snapshot.data[index].toString());
                      User user = User.fromSnapShot(snapshot.data[index]);
                      return Container(
                          width: 300,
                          margin:
                              EdgeInsets.only(left: 50, top: 20, bottom: 80),
                          child: GestureDetector(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString(
                                  "user", jsonEncode(user.toMap()));
                              preferences.setBool("isFirstTime", false);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                            child: Material(
                              elevation: 11,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                          text: 'Name: ',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: user.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    fontFamily: 'nunito'))
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: 'National ID: ',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: user.id,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    fontFamily: 'nunito'))
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "Username: ",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                                text: user.username,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    fontFamily: 'nunito'))
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    });
              }
            } else if (snapshot.hasError) {
              _body = Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              _body = Center(
                child: CircularProgressIndicator(),
              );
            }
            return _body;
          }),
    );
  }
}
