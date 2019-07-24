import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  const CategoryTile({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data["icon"]),
          ),
          title: Text(
            snapshot.data["title"],
            style: TextStyle(color: Colors.grey[850], fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: snapshot.reference.collection("items").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData) return Container();
                return Column(
                  children: snapshot.data.documents.map((doc){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doc.data["images"][0]),
                      ),
                      title: Text(doc.data["title"]),
                      trailing: Text(
                        "R\$ ${doc.data["price"].toStringAsFixed(2)}"
                      ),
                      onTap: (){

                      },
                    );
                  }).toList()..add(
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.add, color: Colors.blue,),
                      ),
                      title: Text("Adicionar"),
                      onTap: (){

                      },
                    )
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
