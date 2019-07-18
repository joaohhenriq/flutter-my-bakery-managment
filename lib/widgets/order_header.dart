import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {

  final style1 = TextStyle(
    fontSize: 13,
  );

  final style2 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("João Henrique", style: style1,),
            Text("Rua da Ostra", style: style1,)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Products price", style: style2,),
            Text("Total price", style: style2,)
          ],
        )
      ],
    );
  }
}
