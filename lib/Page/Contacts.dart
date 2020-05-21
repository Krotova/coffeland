import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:coffeland/Firebase/firebase.dart';
import "package:coffeland/Scripts/Scripts.dart";
import 'package:coffeland/main.dart';
class Contacts extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: _Contacts(),
    );
  }
}

class _Contacts extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<_Contacts> {
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  int _counter = 0;
  TextEditingController login = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repPassword = new TextEditingController();
  FireBaseCustom fbc = new FireBaseCustom();
  Scripts gunSC = new Scripts();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.red])
        ),
        child: ListView(
          padding: EdgeInsets.all(50),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/logo.png"),
                Text(
                  "Контакты",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15,),
               Text(
                 "Свяжитесь с нами через :\n "
                     "Моб. телефон : +380504568417\n"
                     "e-mail : coffenald@gmail.com ",
                 textAlign: TextAlign.center,
                 style:TextStyle(
                   color: Colors.white,
                    fontSize: 20,
                 ),
               ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
