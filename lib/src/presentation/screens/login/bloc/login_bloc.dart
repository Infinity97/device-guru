import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_guru/src/data/repositories/users_repository.dart';
import 'package:device_guru/src/utils/constants/constants.dart';
import 'package:device_guru/src/utils/constants/language-constants.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UsersRepository usersRepository;

  LoginBloc(this.usersRepository) : super(InitialLoginState());

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield InitialLoginState();
    if (event is LogInOrSignUp) {
      print("LogIn Or Sign UP EVENT Activated");
      yield LoadingLoginState();
      print("STATE:- LoadingLogin");
      try {

//        userResponseEntity.then((value) => print("User response entity:-" + value.responseObject.toString()));
//        SharedPrefs sharedPrefs = new SharedPrefs();
//        sharedPrefs.setId()

        yield LoadedLoginState();
        print("STATE:- LOADED LOGIN STATE");
      } catch (Exception) {
        yield ErrorLoginState(LanguageConstants.errorMessage[Constants.ENG]??"");
      }
    }
  }
}
