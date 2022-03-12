import 'package:kiwi/model/user.dart';

abstract class DbBase{
  Future<bool> saveUser(MyUser user );
  Future<MyUser> readUser(String userID );


}