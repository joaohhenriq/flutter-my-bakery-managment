import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _titleController = BehaviorSubject<String>();
  final _imageController =
      BehaviorSubject(); //não especifíca tipo pq pode ser tanto uma url(string) quanto um file (registro ainda não salvo)
  final _deleteController = BehaviorSubject<bool>();

  Stream<String> get outTitle => _titleController.stream;
  Stream get outImage => _imageController.stream;
  Stream<bool> get outDelete => _deleteController.stream;

  DocumentSnapshot category;

  CategoryBloc(this.category){
    if(category != null){ // se categoria já está salva no firebase
      _titleController.add(category.data["title"]);
      _imageController.add(category.data["icon"]);
      _deleteController.add(true);
    } else {
      _deleteController.add(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.close();
    _imageController.close();
    _deleteController.close();
  }
}
