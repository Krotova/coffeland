import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SessionShop {

  static final SessionShop _singleton = SessionShop._internal();
  factory SessionShop() => _singleton;
  SessionShop._internal();
  static SessionShop get shared => _singleton;
  String name;
  String id;
  Map<dynamic, dynamic> allProduct;
  Map<dynamic, dynamic> buyList;
  var typeList = 0;
}