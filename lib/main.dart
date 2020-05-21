import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:coffeland/Page/Reg.dart';
import 'package:coffeland/Page/ListProduct.dart';

import 'package:coffeland/Firebase/firebase.dart';
import "package:coffeland/Scripts/Scripts.dart";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'coffe',
    options:  const FirebaseOptions(
      googleAppID: '1:828882068276:android:93c8c9529288a6cdc37b61',
      apiKey: 'AIzaSyBJVM5bkz3g16uYMtXst25PApokFv7e_Kc',
      databaseURL: 'https://gunmarket-348b4.firebaseio.com',
    ),
  );
  final databaseReference = FirebaseDatabase.instance.reference();
//  databaseReference.child("items").set({
//    'title': 'Mastering EJB',
//    'description': 'Programming Guide for J2EE'
//  });
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Database Example',
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  TextEditingController login = new TextEditingController();
  TextEditingController password = new TextEditingController();
  int _counter = 0;
  FireBaseCustom fbc = new FireBaseCustom();
  Scripts gunSC = new Scripts();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:
      Container(
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
                    "COFFELAND",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: login,
                    decoration:InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                        hintText: "Логин"
                    ),
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.black
                    ),

                  ),
                  SizedBox(height: 15,),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "Пароль"
                    ),
                    cursorColor: Colors.white,
                    style: TextStyle(
                        color: Colors.black
                    ),

                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(

                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      onPressed: (){
                        var user = {
                          "login": login.text,
                          "password" : password.text,
                        };
                        if(login.text == "" || login.text == null)
                          return gunSC.showDialogInfo(context, "Ошибка ввода", "Введите логин");
                        if(password.text == "" || password.text == null)
                          return gunSC.showDialogInfo(context, "Ошибка ввода", "Введите пароль");
                        fbc.autorisation(context,"user", user);

                      },
                      child: Text(
                        "Авторизоваться",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      padding: EdgeInsets.all(10),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegPage()),
                        );
                      },
                      child: Text(
                        "Регистрация",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
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
