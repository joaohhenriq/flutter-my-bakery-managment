import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _usersController = BehaviorSubject();

  Map<String, Map<String, dynamic>> _users = {};

  Firestore _firestore = Firestore.instance;

  UserBloc() {
    _addUsersListener();
  }

  void _addUsersListener() {
    _firestore.collection("users").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String uid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            //no caso de mudar só algum dado do usuário, e não dos pedidos
            _usersController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _usersController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]["subscription"] = _firestore
        .collection("users")
        .document(uid)
        .collection("orders")
        .snapshots()
        .listen((orders) async {
      int numOrders = orders.documents.length;

      double money = 0.0;

      for (DocumentSnapshot d in orders.documents) {
        DocumentSnapshot order =
            await _firestore.collection("orders").document(d.documentID).get();

        if(order.data == null) continue;

        money += order.data["totalPrice"];
      }

      _users[uid].addAll(
        {
          "money": money,
          "orders": numOrders
        }
      );

      //.values para pegar só a parte do mapa dentro do mapa, desconsiderando a chave
      _usersController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid){
    _users[uid]["subscription"].cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _usersController.close();
  }
}
