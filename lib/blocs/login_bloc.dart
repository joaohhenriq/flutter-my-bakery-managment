import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:my_bakery_managment/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);

  // stream para acionar o botão de login
  // valida se os valores de email e password estão preenchidos
  // poderia combinar mais valores, mas estamos usando somente 2
  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail,
      outPassword,
      (a, b) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    super.dispose();
  }
}