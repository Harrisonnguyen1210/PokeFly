import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An error occurred'),
        content: Text('Please check your internet connection or try again later!'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }
}
