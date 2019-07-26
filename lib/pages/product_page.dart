import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/product_bloc.dart';

class ProductPage extends StatelessWidget {
  final String categoryId;
  final DocumentSnapshot product;

  final ProductBloc _productBloc;

  final _formKey = GlobalKey<FormState>();

  ProductPage({this.categoryId, this.product})
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10.0,),
                        Text("New product", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: (){
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: (){
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: <Widget>[],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
