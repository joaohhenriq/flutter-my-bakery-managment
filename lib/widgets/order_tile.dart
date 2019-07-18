import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#123qwe123 - Delivery",
            style: TextStyle(
              color: Colors.green,
              fontSize: 15
            ),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Cheese cake"
                        ),
                        subtitle: Text(
                          "cakes/alskdfjslkdçlskdfj"
                        ),
                        trailing: Text(
                          "2",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){},
                        textColor: Colors.red,
                        child: Text("Delete"),
                      ),
                      FlatButton(
                        onPressed: (){},
                        textColor: Colors.grey[850],
                        child: Text("Delete"),
                      ),
                      FlatButton(
                        onPressed: (){},
                        textColor: Colors.green,
                        child: Text("Delete"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
