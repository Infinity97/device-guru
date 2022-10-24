import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState{
  @override
  List<Object> get props => [];
}

class LoadedLoginState extends LoginState{

  LoadedLoginState();

  @override
  List<Object> get props =>[];
}

class ErrorLoginState extends LoginState{
  final String msg;
  ErrorLoginState(this.msg);

  @override
  List<Object> get props =>[msg];
}
