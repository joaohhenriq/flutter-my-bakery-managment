import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "title",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          Text(
            "Orders: 0",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "subtitle",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          Text(
            "Total: 0",
            style: TextStyle(color: Colors.white),
          )
        ],
      )
    );
  }
}
