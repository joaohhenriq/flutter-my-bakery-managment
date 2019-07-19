import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/orders_bloc.dart';
import 'package:my_bakery_managment/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.getBloc<OrdersBloc>();
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
        child: StreamBuilder<List>(
            stream: _ordersBloc.outOrders,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                );
              else if (snapshot.data.length == 0)
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Nenhum pedido encontrado!",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              else
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return OrderTile(snapshot: snapshot.data[index]);
                  },
                );
            }),
      ),
    );
  }
}
