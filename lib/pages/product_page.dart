import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/product_bloc.dart';
import 'package:my_bakery_managment/widgets/images_widget.dart';

class ProductPage extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductPage({this.categoryId, this.product});

  @override
  _ProductPageState createState() => _ProductPageState(categoryId, product);
}

class _ProductPageState extends State<ProductPage> {
  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();

  _ProductPageState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(
        color: Colors.black87,
        fontSize: 16.0
    );

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),

      );
    }

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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10.0,),
                        Text("New product", style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: StreamBuilder<Map>(
                        stream: _productBloc.outData,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();
                          return ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              Text("Images", style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),),
                              ImagesWidget(
                                context: context,
                                initialValue: snapshot.data["images"],
                                onSaved: (l){},
                                validator: (l){},
                              ),
                              TextFormField(
                                initialValue: snapshot.data["title"],
                                style: _fieldStyle,
                                decoration: _buildDecoration("Title"),
                                onSaved: (t) {

                                },
                                validator: (t) {

                                },
                              ),
                              TextFormField(
                                initialValue: snapshot.data["description"],
                                style: _fieldStyle,
                                maxLines: 6,
                                decoration: _buildDecoration("Description"),
                                onSaved: (t) {

                                },
                                validator: (t) {

                                },
                              ),
                              TextFormField(
                                initialValue: snapshot.data["price"]
                                    ?.toStringAsFixed(2),
                                style: _fieldStyle,
                                decoration: _buildDecoration("Price"),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                onSaved: (t) {

                                },
                                validator: (t) {

                                },
                              ),
                            ],
                          );
                        }
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
