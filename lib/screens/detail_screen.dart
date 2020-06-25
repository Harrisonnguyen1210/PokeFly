import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const route = '/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IconButton(
          color: Colors.yellow,
          icon: Icon(Icons.favorite),
          onPressed: null,
        ),
      ),
    );
  }
}
