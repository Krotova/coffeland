import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import "package:coffeland/Scripts/Scripts.dart";
import "package:coffeland/Scripts/SessionUser.dart";
import 'package:coffeland/Page/ListProduct.dart';
import 'package:coffeland/Page/ViewProduct.dart';
class FireBaseCustom {
  FirebaseApp app;
  Scripts gunSC = new Scripts();

  FireBaseCustom() {
    initConfig();
  }

  void initConfig() async {
    app = await FirebaseApp.configure(
      name: 'db2',
      options: const FirebaseOptions(
        googleAppID: '1:888536480911:android:efa9be71306398cfde84fa',
        apiKey: 'AIzaSyCUcn4B-wK_5fJ3ov-9JBRMih_HpAUhYDA"',
        databaseURL: 'https://coffeland-583b8.firebaseio.com',
      ),
    );
  }

  //Firebase Start
  insert(table, json) {
    final databaseReference = FirebaseDatabase.instance.reference();
    var result = databaseReference.child(table).push().set(json);
  }

  autorisation(context, table, json) {
    final databaseReference = FirebaseDatabase.instance.reference().child(
        table);

    databaseReference.once().then((DataSnapshot snapshot) {
      var logic = 0;
      Map<dynamic, dynamic> values = snapshot.value;
      if (values != null)
        values.forEach((key, values) {
          if (json["login"] == values["login"] &&
              json["password"] == values["password"]) {
            logic = 1;
            SessionShop.shared.name = values["login"];
            SessionShop.shared.id = key.toString();

            return Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListProductPage()),);
          }
        });
      if (logic == 0)
        gunSC.showDialogInfo(
            context, "Ошибка данных", "Пользователя не существует");
    });
  }

  //App db function
  void regUser(context, jsons) {
    var table = "user";
    final databaseReference = FirebaseDatabase.instance.reference().child(
        table);

    databaseReference.once().then((DataSnapshot snapshot) {
      var logic = 0;
      Map<dynamic, dynamic> values = snapshot.value;
      print("Select user");
      if (values != null)
        values.forEach((key, values) {
          if (jsons["login"] == values["login"]) {
            logic = 1;
          }
        });
      if (logic == 0) {
        this.insert(table, jsons);
        gunSC.showDialogInfo(context, "Регистрация", "Успешно");
      }
      else {
        gunSC.showDialogInfo(context, "Регистрация", "Логин существует");
      }
    });
  }

  void insertProduct(context, jsons) {
    var table = "product";
    this.insert(table, jsons);
    return gunSC.showDialogInfo(context, "Продукт", "Успешно");
  }
  void insertBuy(context, jsons) {
    var table = "buy";
    this.insert(table, jsons);
    SessionShop.shared.buyList[SessionShop.shared.buyList.length+1] = jsons;
    return gunSC.showDialogInfo(context, "Продукт", "Успешно куплен "+jsons["name"]+" за "+  jsons["cost"] + " грн");
  }
  selectBuyList() {
    var table = "buy";
    Map<dynamic, dynamic> buyList ;
    final databaseReference = FirebaseDatabase.instance.reference().child(
        table);

    databaseReference.once().then((DataSnapshot snapshot) {
      var js = jsonEncode(snapshot.value);
      Map maps = jsonDecode(js);
      if(maps!=null && snapshot != null)
         SessionShop.shared.buyList = maps;

    });
    print(buyList);
  }
  viewSelectBuyList(context){
    List <Widget> list = new List<Widget>();
    try {
      if (SessionShop.shared.buyList != null)
        SessionShop.shared.buyList.forEach((key, value) {
          list.add(
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 10,top:10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Вы купили ",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  Text(
                      value["name"],
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  Text(
                    value["cost"],
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            )
          );
        });
        return Column(children: list);
    }
    catch(e){
      print(e);
    }
  }
  selectProduct() async {
    var table = "product";
    List <Widget> list = new List<Widget>();

    final databaseReference = FirebaseDatabase.instance.reference().child(
        table);

    databaseReference.once().then((DataSnapshot snapshot) {
      var js = jsonEncode(snapshot.value);
      Map maps = jsonDecode(js);
      if(maps!=null && snapshot != null)
        SessionShop.shared.allProduct = maps;
    });
    if(SessionShop.shared.allProduct != null)
      SessionShop.shared.allProduct.forEach((key, value) {
        list.add(Text(value["name"]));
    });
    return Column(children: list);
  }

  viewSelectProduct(context) {
    List <Widget> list = new List<Widget>();
    try {
      if(SessionShop.shared.allProduct != null)
      SessionShop.shared.allProduct.forEach((key, value) {
        if(key == null)
          return;
        if(SessionShop.shared.typeList == -1)
          list.add(
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewProductPage(
                      value["url"].toString(),
                      value["name"].toString(),
                      value["cost"].toString(),
                      value["text"].toString(),
                    )),
                  );
                },
                child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      value["url"].toString(),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Text(
                      value["name"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Text(
                      value["cost"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],),
            ),
              ));
        if(SessionShop.shared.typeList != -1)
          if(SessionShop.shared.typeList == value["type"])
            list.add(GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProductPage(
                    value["url"].toString(),
                    value["name"].toString(),
                    value["cost"].toString(),
                    value["text"].toString(),
                  )),
                );
              },
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      value["url"].toString(),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Text(
                      value["name"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Text(
                      value["cost"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],),
              ),
            ));
      });
      return Column(children: list,);
    }
    catch(e){

    }
  }
}