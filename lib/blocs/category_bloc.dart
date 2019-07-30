import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();
  final _imageController =
      BehaviorSubject(); //não especifíca tipo pq pode ser tanto uma url(string) quanto um file (registro ainda não salvo)
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTitle => _titleController.stream.transform(
          StreamTransformer<String, String>.fromHandlers(
              handleData: (title, sink) {
        if (title.isEmpty)
          sink.addError("Enter a title");
        else
          sink.add((title));
      }));

  Stream get outImage => _imageController.stream;

  Stream<bool> get outDelete => _deleteController.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(outTitle, outImage, (a, b) => true);

  DocumentSnapshot category;

  File image;
  String title;

  CategoryBloc(this.category) {
    if (category != null) {

      title = category.data["title"];

      // se categoria já está salva no firebase
      _titleController.add(category.data["title"]);
      _imageController.add(category.data["icon"]);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  void setImage(File file) {
    this.image = file;
    _imageController.add(file);
  }

  void setTitle(String title) {
    this.title = title;
    _titleController.add(title);
  }

  Future saveData() async {
    if (image == null && category != null && title == category.data["title"])
      return; // quer dizer que nada mudou, não houve alteração na categoria

    Map<String, dynamic> dataToUpdate = {};

    if (image != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child("icons")
          .child(title)
          .putFile(image);
      StorageTaskSnapshot snap = await task.onComplete;
      dataToUpdate["icon"] = await snap.ref.getDownloadURL();
    }

    if (category == null || title != category.data["title"]) {
      dataToUpdate["title"] = title;
    }

    if (category == null) {
      // se a categoria ainda não existe no firebase, uma nova categoria
      await Firestore.instance
          .collection("products")
          .document(title.toLowerCase())
          .setData(dataToUpdate);
    } else {
      // se já existe, apenas atualiza a categoria
      await category.reference.updateData(dataToUpdate);
    }
  }

  void delete(){
    category.reference.delete();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}
