
import 'package:flutter/material.dart';
import 'package:kiwi/model/user.dart';
import 'package:kiwi/repository/user_repository.dart';
import 'package:kiwi/services/auth_base.dart';

import '../locator.dart';
enum ViewState{Idle,Busy}
class UserModel with ChangeNotifier implements AuthBase{
ViewState _state =ViewState.Idle;
UserRepository _userRepository=locator<UserRepository>();
MyUser _user;
String emailErrorMessage;
String passwordErrorMessage;

MyUser get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }
UserModel(){
    getcurrentUser();
}
  @override
  Future<MyUser> getcurrentUser() async{
    try{
      state =ViewState.Busy;
     _user= await _userRepository.getcurrentUser();
      if(_user!=null)
        return _user;
      else
        return null;
    }catch(e){
      debugPrint("vievmodel current user xeta"+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInAnonymously()async {
    try{
      state =ViewState.Busy;
       _user = await _userRepository.signInAnonymously();
       return _user;
    }catch(e){
      debugPrint("vievmodel current user xeta"+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }

  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
     bool sonuc= await _userRepository.signOut();
     _user=null;
     return sonuc;
    } catch (e) {
      debugPrint("vievmodel current user xeta" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async{
    try{
      state =ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    }catch(e){
      debugPrint("vievmodel current user xeta"+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInWithFacebook()async {
    try{
      state =ViewState.Busy;
      _user = await _userRepository.signInWithFacebook();
      return _user;
    }catch(e){
      debugPrint("vievmodel current user xeta"+e.toString());
      return null;
    }finally{
      state=ViewState.Idle;
    }
  }

  @override
  Future<MyUser> createUserWithEmailandPassword(String email, String password)async {

      if(_emailShifreCheck(email, password)) {
          try{
            state = ViewState.Busy;
            _user =
            await _userRepository.createUserWithEmailandPassword(email, password);
            return _user;
          }finally{
            state=ViewState.Idle;
          }
      } else return null;

  }

  @override
  Future<MyUser> signInWithEmailandPassword(String email, String password)async {
    try{
      if(_emailShifreCheck(email, password)){
        state =ViewState.Busy;
        _user = await _userRepository.signInWithEmailandPassword(email, password);
        return _user;
      }
    }
    finally{
      state=ViewState.Idle;
    }
  }
  bool _emailShifreCheck(String email,String password){
    var sonuc =true;
    if(password.length <6){
      passwordErrorMessage ="En az 6 Karakter olmali";
      sonuc =false;
    }else passwordErrorMessage =null;
    if(!email.contains('@')){
      emailErrorMessage="Kecersiz email daxil edildi";
      sonuc =false;
    }else  emailErrorMessage=null;
    return sonuc;
  }
}