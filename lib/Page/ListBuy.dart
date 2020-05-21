import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/widgets.dart';
import 'package:coffeland/Firebase/firebase.dart';
import 'package:coffeland/Page/ListProduct.dart';
import "package:coffeland/Scripts/Scripts.dart";
import 'package:coffeland/main.dart';
String url,name,cost,text = "";
class ListBuyPage extends StatelessWidget {
  ViewProductPage(_url,_name,_cost,_text,){
    url = _url;
    name = _name;
    cost = _cost;
    text = _text;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: _ListBuyPage(),
    );
  }
}

class _ListBuyPage extends StatefulWidget {
  @override
  _ListBuyPageState createState() => _ListBuyPageState();
}

class _ListBuyPageState extends State<_ListBuyPage> {
  _ListBuyPageState(){
    fbc.selectBuyList();
  }
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  int _counter = 0;
  TextEditingController login = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repPassword = new TextEditingController();
  FireBaseCustom fbc = new FireBaseCustom();
  @override
  Widget build(BuildContext context) {
    setState(() {
      fbc.selectBuyList();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListProductPage()));
              },
            ),
            Text("Список покупок"),
          ],
        ),
      ),
      body: Container(
        child:  fbc.viewSelectBuyList(context),
      ),
    );
  }
}
