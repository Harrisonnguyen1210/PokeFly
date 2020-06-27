import 'package:flutter/material.dart';
import 'package:poke_fly/models/type_color.dart';
import 'package:poke_fly/utils/string_extension.dart';

class TypeTag extends StatelessWidget {
  final String type;

  TypeTag(this.type);

  Color _getTypeColor(String type) {
    return TypeColor.typeColors[type] != null
        ? TypeColor.typeColors[type][1]
        : TypeColor.typeColors['normal'][1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: _getTypeColor(type),
      ),
      margin: EdgeInsets.only(top: 8, right: 8),
      padding: EdgeInsets.all(4),
      child: Row(
        children: <Widget>[
          // add icons here for future improvement
          Text(
            type.firstLetterCapitalize(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
