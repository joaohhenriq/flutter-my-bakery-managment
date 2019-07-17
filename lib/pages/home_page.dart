import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/user_bloc.dart';
import 'package:my_bakery_managment/tabs/orders_tab.dart';
import 'package:my_bakery_managment/tabs/products_tab.dart';
import 'package:my_bakery_managment/tabs/users_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;

  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.black87,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white54))),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (page) {
            _pageController.animateToPage(page,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Clients")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Orders")),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text("Products")),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          blocs: [
            Bloc((i) => _userBloc)
          ],
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            children: <Widget>[
              UsersTab(),
              OrdersTab(),
              ProductsTab()
            ],
          ),
        ),
      ),
    );
  }
}
