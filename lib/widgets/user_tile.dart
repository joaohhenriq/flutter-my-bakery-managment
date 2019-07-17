import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    if (user.containsKey("money"))
      return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                user["name"],
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Orders: ${user["orders"]}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                user["email"],
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Total: R\$${user["money"].toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              )
            ],
          ));
    else
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 135,
                  height: 20,
                  child: Shimmer.fromColors(
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.symmetric(vertical: 4),
                      ),
                      baseColor: Colors.white,
                      highlightColor: Colors.grey),
                ),
                SizedBox(
                  width: 60,
                  height: 20,
                  child: Shimmer.fromColors(
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.symmetric(vertical: 4),
                      ),
                      baseColor: Colors.white,
                      highlightColor: Colors.grey),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 20,
                  child: Shimmer.fromColors(
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.symmetric(vertical: 4),
                      ),
                      baseColor: Colors.white,
                      highlightColor: Colors.grey),
                ),
                SizedBox(
                  width: 80,
                  height: 20,
                  child: Shimmer.fromColors(
                      child: Container(
                        color: Colors.white.withAlpha(50),
                        margin: EdgeInsets.symmetric(vertical: 4),
                      ),
                      baseColor: Colors.white,
                      highlightColor: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
