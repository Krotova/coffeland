import 'package:flutter/material.dart';
import "package:firebase_database/firebase_database.dart";
import "package:firebase_database/ui/firebase_animated_list.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:coffeland/Firebase/firebase.dart';
import 'package:coffeland/Page/ListProduct.dart';
import "package:coffeland/Scripts/Scripts.dart";
import 'package:coffeland/main.dart';
import 'package:coffeland/Scripts/Array.dart';

class addProduct extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
        debugShowCheckedModeBanner: false,
      home:Container(
        width: double.infinity,
        height: double.infinity,
        child: _addProduct(),
      )

    );
  }
}

class _addProduct extends StatefulWidget {
  @override
  _addProductState createState() => _addProductState();
}

class _addProductState extends State<_addProduct> {
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  var typeCoffe = "";
  int _counter = 0;
  TextEditingController name = new TextEditingController();
  TextEditingController text = new TextEditingController();
  TextEditingController url = new TextEditingController();
  TextEditingController cost = new TextEditingController();

  FireBaseCustom fbc = new FireBaseCustom();
  Scripts gunSC = new Scripts();
  Array array = new Array();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListProductPage()));

              },
              icon: Icon(Icons.arrow_back),
            ),
            Text("Добавление товара")
          ],
        ),
      ),
      body:
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Text(
              "Заполните все поля для добавления товара в магазин CoffeLand",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Название товара",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: name,
            ),
            SizedBox(height: 10),
            Text(
              "Описание товара",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: text,
            ),
            SizedBox(height: 10),
            Text(
              "Ссылка на картинку товара",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: url,
            ),
            SizedBox(height: 10),
            Text(
              "Стоимость товара",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cost,
            ),
            SizedBox(height: 10),
            DropdownButton(
              hint: Text("Тип товара"),
              onChanged: (value){
                setState(() {
                  typeCoffe = value;
                });
                print(value);
              },
              value: typeCoffe == "" ? null : typeCoffe,
              items: array.typeCoffe.map((data){
                return DropdownMenuItem(
                  child: Text(data),
                  value: data,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            RaisedButton(
              padding: EdgeInsets.all(20),
              color: Colors.green,
              onPressed: (){
                if(name.text == "" || name.text == null)
                  return gunSC.showDialogInfo(context, "Ошибка ввода", "Заполните название продукта");
                if(text.text == "" || text.text == null)
                  return gunSC.showDialogInfo(context, "Ошибка ввода", "Заполните описание продукта");
                if(url.text == "" || url.text == null)
                  return gunSC.showDialogInfo(context, "Ошибка ввода", "Заполните url картинки продукта");
                if(cost.text == "" || cost.text == null)
                  return gunSC.showDialogInfo(context, "Ошибка ввода", "Заполните стоимость продукта");
                if(array.typeCoffe.indexOf(typeCoffe) == -1)
                  return gunSC.showDialogInfo(context, "Ошибка ввода", "Заполните тип продукта");
                var product = {
                  "name" : name.text,
                  "text" : text.text,
                  "url" : url.text,
                  "cost": cost.text,
                  "type" : array.typeCoffe.indexOf(typeCoffe),
                };
                fbc.insertProduct(context, product);
              },
              child: Text(
                "Добавить",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
