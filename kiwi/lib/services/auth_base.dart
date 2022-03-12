


import 'package:kiwi/model/user.dart';

abstract class AuthBase{
 Future<MyUser>  getcurrentUser();
 Future<MyUser> signInAnonymously();
 Future<bool> signOut();
  Future<MyUser> signInWithGoogle();
 Future<MyUser> signInWithFacebook();
 Future<MyUser> signInWithEmailandPassword(String email,String password );
 Future<MyUser> createUserWithEmailandPassword(String email,String password );






}