import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LogInOrSignUp extends LoginEvent{
  final String mobileNumber;
  LogInOrSignUp(this.mobileNumber);

  @override
  List<Object> get props =>[mobileNumber];
}