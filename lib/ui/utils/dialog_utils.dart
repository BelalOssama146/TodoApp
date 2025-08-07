import 'package:flutter/material.dart';

abstract class Dialog{
  void showLoading(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content:   Row(
          children: [
            Text("Loading"),
            Spacer(),
            CircularProgressIndicator(),
          ],
        ),
      );
    });

  }
  void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
  void showMessage(BuildContext context,
      String? title,
      String? body,
      String? posButtonTitle,
      String? negButtonTitle,
      Function? posButtonClick,
      Function? negButtonClick) {
    showDialog(context: context, builder:(_){
      return AlertDialog(
        title: title != null? Text(title) : null,
        content: body != null? Text(body) : null,
        actions: [
          if(posButtonTitle!=null)
            TextButton(onPressed: (){
              posButtonClick;
            }, child: Text(posButtonTitle)),
          if(negButtonTitle!= null)
            TextButton(onPressed: (){
              negButtonClick;
            }, child: Text(negButtonTitle))
        ],
      );
    }
    );
  }
}