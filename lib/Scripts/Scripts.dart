import 'package:flutter/material.dart';
class Scripts {

  showDialogInfo(context,title,text){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text(title),
            content: new Text(text),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: new Text("Хорошо")
              )
            ],
          );
        }
    );
  }

}