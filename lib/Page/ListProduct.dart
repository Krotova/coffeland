import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:coffeland/Page/ListBuy.dart';
import 'package:coffeland/Scripts/SessionUser.dart';
import 'package:coffeland/Page/addProduct.dart';
import 'package:coffeland/Page/Contacts.dart';
import 'package:coffeland/Firebase/firebase.dart';

class ListProductPage extends StatelessWidget {
  final appTitle = SessionShop.shared.name.toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Container(
        width: double.infinity,
        height: double.infinity,
        child: LPState(),
      )

    );
  }
}
class LPState  extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}


class MyHomePage extends State<LPState> {

  FireBaseCustom fbGS = new FireBaseCustom();

  MyHomePage(){
      fbGS.selectProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(SessionShop.shared.name.toString()),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => addProduct()),);
                    },
                  ),
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListBuyPage()),);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
          ),
        ],
        ),

        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
          fbGS.viewSelectProduct(context),
          ],
        )
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.red])
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset("assets/logo.png"),
                decoration: BoxDecoration(

                ),
              ),
              ListTile(
                title: Text(
                  'Главная',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  setState(() {
                    SessionShop.shared.typeList = -1;
                  });

                },
              ),
              ListTile(

                title: Text(
                'Кофе',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
                onTap: () {
                  setState(() {
                    SessionShop.shared.typeList = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Посуда',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  setState(() {
                    SessionShop.shared.typeList = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Напитки',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  setState(() {
                    SessionShop.shared.typeList = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Контакты',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Contacts()),);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}