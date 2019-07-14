import 'package:flutter/material.dart';
import 'package:my_bakery_managment/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/login_background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "My Bakery Managment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "DancingScript", fontSize: 55, color: Colors.white, fontWeight: FontWeight.w500),
                          )),
                      InputField(
                        icon: Icons.person_outline,
                        hint: "User",
                        obscure: false,
                      ),
                      InputField(
                        icon: Icons.lock_outline,
                        hint: "Password",
                        obscure: true,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          height: 50.0,
                          child: RaisedButton(
                            color: Colors.white.withOpacity(0.5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Icon(Icons.input)
                              ],
                            ),
                            onPressed: () {},
                            textColor: Colors.white,
                          ),
                        ),
                      )
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
}
