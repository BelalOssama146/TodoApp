import 'package:flutter/material.dart';

Future <void> showLoading(BuildContext context) {
  return showDialog(context: context,
      //  barrierDismissible: false,
      builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            Text("Loading"),
            Spacer(),
            CircularProgressIndicator()
          ],
        ),
      );
    });
  }
  void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

Future<void> showMessage(BuildContext context,
    {String? title,
      String? body,
      String? posButtonTitle,
      String? negButtonTitle,
      Function? posButtonClick,
      Function? negButtonClick,
      bool isDismissible = true}) {
  return showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: title != null? Text(title) : null,
        content: body != null? Text(body) : null,
        actions: [
          if(posButtonTitle!=null)
            TextButton(onPressed: (){
              posButtonClick;
              Navigator.pop(context);
            }, child: Text(posButtonTitle)),
          if(negButtonTitle!= null)
            TextButton(onPressed: (){
              negButtonClick;
              Navigator.pop(context);
            }, child: Text(negButtonTitle))
        ],
      );
    }
    );
  }
