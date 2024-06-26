import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

 late final title;
 late final content;
 late final VoidCallback callback;
 late final actionText;

  CustomDialog(this.title,this.content,this.callback,[this.actionText="Reset"]){}


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [TextButton(
        onPressed: callback,
        style: TextButton.styleFrom(backgroundColor: Colors.white),
        child:Text(actionText),)],
    );
  }
}
