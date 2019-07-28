import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>(); //para verificar se o produto já está criado ou não

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData;

  ProductBloc({this.product, this.categoryId}) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData["images"] = List.of(product.data["images"]);
      unsavedData["sizes"] = List.of(product.data["sizes"]);

      // produto já cadastrado
      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };

      // produto não cadastrado
      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void savePrice(String price) {
    unsavedData["price"] = double.parse(price);
  }

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  void saveSizes(List sizes) {
    unsavedData["sizes"] = sizes;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      // se já existe o produto, temos somente que atualizar os dados
      if (product != null) {
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedData);
      } else {
        DocumentReference dr = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("items")
            // para guardar as images, tem que ter o id do produto primeiro,
            // porém nesse momento ainda não existe esse id pq o produto não foi gravado no banco de dados ainda
            // por isso tem que remover as imagens do produto primeiro
            // então manda salvar todos os dados do produto, menos as imagens
            // o Map.from faz um clone do nosso unsaveddata, portanto não excluir as images do registro original
            // somente desse clone, e então posteriormente teremos acesso às imagens novamente
            .add(Map.from(unsavedData)..remove("images"));

        await _uploadImages(dr.documentID);
        await dr.updateData(unsavedData);

        _createdController.add(true);
        _loadingController.add(false);
        return true;
      }
    } catch (e) {
      _loadingController.add(false);
      return false;
    }

    _loadingController.add(false);

    return true;
  }

  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      // Se for string, já está no firebase, então ignora e continua a execução do for
      if (unsavedData["images"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData["images"][i]);

      StorageTaskSnapshot s = await uploadTask.onComplete;

      String downloadUrl = await s.ref.getDownloadURL();

      // antes a imagem era um file, e depois de salvar transforma em uma url
      // mostrando que já está salvo no banco de dados
      unsavedData["images"][i] = downloadUrl;
    }
  }

  void deleteProduct(){
    product.reference.delete();
  }

  @override
  void dispose() {
    _loadingController.close();
    _dataController.close();
    _createdController.close();
    super.dispose();
  }
}
