import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/model/model.dart';
import 'package:think_tank/screens/insert.dart';
import 'package:think_tank/screens/login.dart';

class Home extends StatelessWidget {
  User user;
  Future<User> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("user")) {
      var map = jsonDecode(preferences.get("user"));
      return User.fromMap(map);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return _body(context);
          } else if (snapshot.hasError) {
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: _drawer(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: 'Welcome back ',
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Nunito',
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: user.username,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'nunito'))
                  ]),
            ),
            Padding(padding: EdgeInsets.all(10)),
            // _stats(),
            Padding(padding: EdgeInsets.all(10)),
            Text('Recent Activity'),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contribution()));
              },
              child: Text("Input"),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white70,
                child: Image.network(
                  "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg",
                  fit: BoxFit.fill,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(user.name),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(user.id),
          ),
          Divider(
            color: Colors.black38,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();

              preferences.clear();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Container(
              height: 40,
              width: double.infinity,
              child: Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chevron_left,
                      color: Colors.red,
                    ),
                    Text(
                      "LOGOUT",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.black38,
          ),
        ],
      ),
    );
  }

  Widget _stats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _cardItem("TOTAL CONTRIBUTION", "12000"),
        _cardItem(
          "MY CONTRIBUTION",
          "2000",
          onClick: () {
            print("my contribution");
          },
        ),
      ],
    );
  }

  Widget _cardItem(String title, String subTitle, {Function onClick}) {
    const style = TextStyle(fontSize: 30);
    return GestureDetector(
      onTap: onClick,
      child: Card(
          elevation: 10,
          color: Colors.white70,
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: style,
                ),
                Text(subTitle)
              ],
            ),
          )),
    );
  }
}
