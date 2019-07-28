import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/product_bloc.dart';
import 'package:my_bakery_managment/validators/product_validator.dart';
import 'package:my_bakery_managment/widgets/images_widget.dart';

class ProductPage extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductPage({this.categoryId, this.product});

  @override
  _ProductPageState createState() => _ProductPageState(categoryId, product);
}

class _ProductPageState extends State<ProductPage> with ProductValidator {
  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
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
                Material(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Row(
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
                          StreamBuilder<bool>(
                              stream: _productBloc.outCreated,
                              initialData: false,
                              builder: (context, snapshot) {
                                return Text(snapshot.data
                                    ? "Edit product"
                                    : "New product", style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),);
                              }
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          StreamBuilder<bool>(
                            stream: _productBloc.outCreated,
                            initialData: false,
                            builder: (context, snapshot) {
                              if (snapshot.data) {
                                return StreamBuilder<bool>(
                                    stream: _productBloc.outLoading,
                                    initialData: false,
                                    builder: (context, snapshot) {
                                      return IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: snapshot.data
                                              ? null
                                              : (){
                                            _productBloc.deleteProduct();
                                            Navigator.of(context).pop();
                                          }
                                      );
                                    }
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          StreamBuilder<bool>(
                              stream: _productBloc.outLoading,
                              initialData: false,
                              builder: (context, snapshot) {
                                return IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: snapshot.data
                                        ? null
                                        : saveProduct
                                );
                              }
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Form(
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
                                    onSaved: _productBloc.saveImages,
                                    validator: validateImages,
                                  ),
                                  TextFormField(
                                    initialValue: snapshot.data["title"],
                                    style: _fieldStyle,
                                    decoration: _buildDecoration("Title"),
                                    onSaved: _productBloc.saveTitle,
                                    validator: validateTitle,
                                  ),
                                  TextFormField(
                                    initialValue: snapshot.data["description"],
                                    style: _fieldStyle,
                                    maxLines: 6,
                                    decoration: _buildDecoration("Description"),
                                    onSaved: _productBloc.saveDescription,
                                    validator: validateDescription,
                                  ),
                                  TextFormField(
                                    initialValue: snapshot.data["price"]
                                        ?.toStringAsFixed(2),
                                    style: _fieldStyle,
                                    decoration: _buildDecoration("Price"),
                                    keyboardType: TextInputType
                                        .numberWithOptions(
                                        decimal: true),
                                    onSaved: _productBloc.savePrice,
                                    validator: validatePrice,
                                  ),
                                ],
                              );
                            }
                        ),
                      ),
                      StreamBuilder<bool>(
                          stream: _productBloc.outLoading,
                          initialData: false,
                          builder: (context, snapshot) {
                            return IgnorePointer(
                                ignoring: !snapshot.data,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: snapshot.data ? Colors.white
                                          .withOpacity(0.7) : Colors
                                          .transparent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))
                                  ),
                                )
                            );
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      //quando fizer isso, chama o onSaved de cada um dos campos abaixo
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              "Saving product...", style: TextStyle(color: Colors.white),),
            duration: Duration(minutes: 1),
            backgroundColor: Colors.blue,
          )
      );

      bool success = await _productBloc.saveProduct();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              success ? "Product saved!" : "Error: product could not be saved!",
              style: TextStyle(color: Colors.white),),
            backgroundColor: success ? Colors.blue : Colors.red,
          )
      );
    }
  }
}
