import 'package:flutter/material.dart';
import 'package:my_bakery_managment/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.fromLTRB(0, 30, 0, 8),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/orders_tab.jpg"),
            fit: BoxFit.cover,
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index){
            return OrderTile();
          },
        ),
      ),
    );
  }
}
