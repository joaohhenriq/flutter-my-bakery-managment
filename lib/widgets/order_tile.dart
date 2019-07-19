import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const OrderTile({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final states = [
      "",
      'Preparing',
      'Delivery',
      'Waiting delivery',
      'Delivered'
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#${snapshot.documentID.substring(snapshot.documentID.length - 7, snapshot.documentID.length)} - ${states[snapshot.data["status"]]}",
            style: TextStyle(
                color: snapshot.data["status"] != 4
                    ? Colors.grey[850]
                    : Colors.green,
                fontSize: 15),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data["products"].map<Widget>((p) {
                        return ListTile(
                          title:
                              Text(p["product"]["title"] + " - " + p["size"]),
                          subtitle: Text(p["category"] + " / " + p["pid"]),
                          trailing: Text(
                            p["quantity"].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          contentPadding: EdgeInsets.zero,
                        );
                      }).toList()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.red,
                        child: Text("Delete"),
                      ),
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.grey[850],
                        child: Text("Regress"),
                      ),
                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.green,
                        child: Text("Progress"),
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
