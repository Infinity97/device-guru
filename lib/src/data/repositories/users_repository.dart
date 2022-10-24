import 'package:device_guru/src/domain/dtos/response/user_response_entity.dart';

abstract class UsersRepository{
  Future<String> fetchReferralCode(String userId);
  String loginOrSignUp(String data);
}