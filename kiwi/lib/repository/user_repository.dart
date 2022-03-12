import 'package:flutter/cupertino.dart';
import 'package:kiwi/model/user.dart';
import 'package:kiwi/services/auth_base.dart';
import 'package:kiwi/services/fake_auth_services.dart';
import 'package:kiwi/services/fireabase_auth_services.dart';
import 'package:kiwi/services/firestore_db_service.dart';

import '../locator.dart';
enum AppMode{DEBUG,RELEASE}
class UserRepository implements  AuthBase{
  FirebaseAuthService _firebaseAuthService =locator<FirebaseAuthService>();
  FakeAuthenticationService _fakeAuthenticationService =locator<FakeAuthenticationService>();
  FireStoreDbService _fireStoreDbService =locator<FireStoreDbService>();

  AppMode appMode =AppMode.RELEASE;
  @override
  Future<MyUser> getcurrentUser() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.getcurrentUser();
    }else{
        return await _firebaseAuthService.getcurrentUser();
    }
  }

  @override

  Future<MyUser> signInAnonymously()async {
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.signInAnonymously();
    }
    else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool> signOut()async {
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.signOut();
    }
    else{
      return await _firebaseAuthService.signOut();

    }
  }

  @override
  Future<MyUser> signInWithGoogle() async{
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithGoogle();
    }
    else {
      MyUser _user =await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _fireStoreDbService.saveUser(_user);
      if(_sonuc){
        return await _fireStoreDbService.readUser(_user.userID);
      }else return null;
    }
  }

  @override
  Future<MyUser> signInWithFacebook()async {
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithFacebook();
    }
    else {
      MyUser _user =await _firebaseAuthService.signInWithFacebook();
      bool _sonuc = await _fireStoreDbService.saveUser(_user);
      if(_sonuc){
        return await _fireStoreDbService.readUser(_user.userID);
      }else return null;
    }
  }

  @override
  Future<MyUser> createUserWithEmailandPassword(String email, String password)async {
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.createUserWithEmailandPassword(email, password);
    }
    else {


    MyUser _user = await _firebaseAuthService.createUserWithEmailandPassword(
        email, password);
    bool _sonuc = await _fireStoreDbService.saveUser(_user);
    if (_sonuc) {
      return await _fireStoreDbService.readUser(_user.userID);
    }
  else return null;



    }
  }

  @override
  Future<MyUser> signInWithEmailandPassword(String email, String password)async {
    if(appMode==AppMode.DEBUG){
      return await _fakeAuthenticationService.signInWithEmailandPassword(email, password);
    }
    else {

      MyUser _user=await _firebaseAuthService.signInWithEmailandPassword(email, password);
      return await _fireStoreDbService.readUser(_user.userID);
    }
    }
  }








