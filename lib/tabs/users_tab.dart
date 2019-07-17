import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/user_bloc.dart';
import 'package:my_bakery_managment/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.getBloc<UserBloc>();

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/users_tab.jpg"),
        fit: BoxFit.cover,
      )),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              margin: EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                    hintText: "Search",
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: StreamBuilder<List>(
                  stream: _userBloc.outUsers,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    } else if (snapshot.data.length == 0) {
                      return Center(
                          child: Text(
                        "Nenhum usuário encontrado!",
                        style: TextStyle(color: Colors.blue),
                      ));
                    } else
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            return UserTile(snapshot.data[index]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: snapshot.data.length);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
