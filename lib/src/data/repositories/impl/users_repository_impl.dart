
import 'package:device_guru/src/data/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {


  @override
  Future<String> fetchReferralCode(String userId) {
    // TODO: implement Write a Code to get information from the Server
    return Future(() {
      return "AEDGHK";
    });
  }

  @override
  String loginOrSignUp(String data) {
    print("Calling the Login Controller");
    // UserResponseEntity userResponseEntity = new UserResponseEntity();
    // try {
    //   Future<UserResponseEntity> userResponseEntityFuture = _loginController
    //       .loginOrSignUp(registerNewUserRequest: registerNewUserRequest);
    //   userResponseEntityFuture.then((value) => userResponseEntity = value);
    //   print("The Response is" + userResponseEntity.toString());
    // }catch(Exception){
    //   print("...An Exception occured when LoginController was called...");
    // }
    // print("The Response is" + userResponseEntity.toString());
    // return userResponseEntity;
    return "Something";
  }
}
