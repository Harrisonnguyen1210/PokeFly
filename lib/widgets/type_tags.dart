import 'package:flutter/material.dart';

class TypeTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.blue),
          margin: EdgeInsets.only(top: 8, right: 8),
          padding: EdgeInsets.all(4),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Bug',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.purple),
          margin: EdgeInsets.only(top: 8, right: 8),
          padding: EdgeInsets.all(4),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Bug',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
