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
class ViewProductPage extends StatelessWidget {
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home: _ViewProduct(),
    );
  }
}

class _ViewProduct extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<_ViewProduct> {
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
            Text(name)
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
           Image.network(
            url,
          ),
          SizedBox(height: 20,),
          Text(
            cost+" грн",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20,),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.pinkAccent,
              onPressed: (){
                var buy ={
                  "name": name,
                  "cost" : cost,
                };
                  fbc.insertBuy(context, buy);
              },
              child: Text(
                  "Купить",
                style: TextStyle(
                    color:Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
