import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:coffeland/Firebase/firebase.dart';
import "package:coffeland/Scripts/Scripts.dart";
import 'package:coffeland/main.dart';
class RegPage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: _RegPage(),
    );
  }
}

class _RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<_RegPage> {
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
                  "РЕГИСТРАЦИЯ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: login,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: "Логин",
                    border: new OutlineInputBorder(
                      borderRadius:
                        const BorderRadius.all(
                          const Radius.circular(10.0),
                      ),
                    ),
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.black
                  ),

                ),
                SizedBox(height: 15,),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                      hintText: "Пароль", border: new OutlineInputBorder(
                    borderRadius:
                    const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(
                      color: Colors.black
                  ),

                ),
                SizedBox(height: 15,),
                TextField(
                  controller: repPassword,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hintText: "Повторите пароль",
                      border: new OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
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
                      if(login.text == "" || login.text == null)
                        return gunSC.showDialogInfo(context,"Ошибка ввода","Заполните логин");
                      if(password.text == "" || password.text == null)
                        return gunSC.showDialogInfo(context,"Ошибка ввода","Заполните пароль");
                      if(repPassword.text != password.text)
                        return  gunSC.showDialogInfo(context,"Ошибка ввода","Пароли не совпадают");
                      var user = {
                        "login": login.text,
                        "password" : password.text,
                      };
                      fbc.regUser(context, user);
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
                SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),);
                    },
                    child: Text(
                      "Вернуться",
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
