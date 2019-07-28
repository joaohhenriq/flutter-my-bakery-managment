import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {

  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData;

  ProductBloc({this.product, this.categoryId}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData["images"] = List.of(product.data["images"]);
      unsavedData["sizes"] = List.of(product.data["sizes"]);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
    }

    _dataController.add(unsavedData);
  }

  void saveTitle(String title){
    unsavedData["title"] = title;
  }

  void saveDescription(String description){
    unsavedData["description"] = description;
  }

  void savePrice(String price){
    unsavedData["price"] = double.parse(price);
  }

  void saveImages(List images){
    unsavedData["images"] = images;
  }

  Future<bool> saveProduct() async{
    _loadingController.add(true);

    await Future.delayed(Duration(seconds: 6));

    _loadingController.add(false);

    return true;
  }

  @override
  void dispose() {
    _loadingController.close();
    _dataController.close();
    super.dispose();
  }
}