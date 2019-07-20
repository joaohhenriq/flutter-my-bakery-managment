import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const OrderHeader(this.snapshot);

  final style1 = const TextStyle(
    fontSize: 13,
  );

  final style2 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500
  );

  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.getBloc<UserBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("${_userBloc.getUser(snapshot.data["clientId"])["name"]}", style: style1,),
            Text("${_userBloc.getUser(snapshot.data["clientId"])["address"]}", style: style1,)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Products: R\$ ${snapshot.data["productsPrice"].toStringAsFixed(2)}", style: style2,),
            Text("Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}", style: style2,)
          ],
        )
      ],
    );
  }
}
