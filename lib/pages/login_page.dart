import 'package:flutter/material.dart';
import 'package:my_bakery_managment/blocs/login_bloc.dart';
import 'package:my_bakery_managment/widgets/input_field.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // como só usamos o loginBloc nesta tela, não precisa colocar em provider
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("Only admins can access!"),
                  ));
          break;
        case LoginState.IDLE:
        case LoginState.LOADING:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

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
        child: StreamBuilder<LoginState>(
            stream: _loginBloc.outState,
            initialData: LoginState.LOADING,
            builder: (context, snapshot) {
              Widget widget;
              switch (snapshot.data) {
                case LoginState.LOADING:
                  widget =  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                  break;
                case LoginState.FAIL:
                case LoginState.SUCCESS:
                case LoginState.IDLE:
                widget = Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "My Bakery Managment",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "DancingScript",
                                        fontSize: 55,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )),
                              InputField(
                                icon: Icons.person_outline,
                                hint: "User",
                                obscure: false,
                                stream: _loginBloc.outEmail,
                                onChanged: _loginBloc.changeEmail,
                              ),
                              InputField(
                                icon: Icons.lock_outline,
                                hint: "Password",
                                obscure: true,
                                stream: _loginBloc.outPassword,
                                onChanged: _loginBloc.changePassword,
                              ),
                              SizedBox(
                                height: 32.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: StreamBuilder<bool>(
                                    stream: _loginBloc.outSubmitValid,
                                    builder: (context, snapshot) {
                                      return SizedBox(
                                        height: 50.0,
                                        child: RaisedButton(
                                          disabledColor:
                                              Colors.white.withOpacity(0.4),
                                          disabledTextColor: Colors.grey[700],
                                          color: Colors.white.withOpacity(0.5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Icon(Icons.input)
                                            ],
                                          ),
                                          onPressed: snapshot.hasData
                                              ? _loginBloc.submit
                                              : null,
                                          textColor: Colors.white,
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                break;
              }

              return widget;
            }),
      ),
    ));
  }
}
