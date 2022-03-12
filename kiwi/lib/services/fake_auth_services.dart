import 'package:kiwi/model/user.dart';
import 'package:kiwi/services/auth_base.dart';


class FakeAuthenticationService implements AuthBase{
  String userID="12113213213213213213";
  @override
  Future<MyUser> getcurrentUser() async{
    return await Future.value(MyUser(userID: userID,email: "fakeuser@fake.com"));
  }

  @override
  Future<MyUser> signInAnonymously() async{
    return await Future.delayed(Duration(seconds: 2),()=>MyUser(userID:userID,email: "fakeuser@fake.com"));
  }

  @override
  Future<bool> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithGoogle()async {
    return await Future.delayed(Duration(seconds: 2),()=>MyUser(userID:"google_userid_12132321321",email: "fakeuser@fake.com"));

  }

  @override
  Future<MyUser> signInWithFacebook() async{
    return await Future.delayed(Duration(seconds: 2),()=>MyUser(userID:"facebook_userid_12132321321",email: "fakeuser@fake.com"));

  }

  @override
  Future<MyUser> createUserWithEmailandPassword(String email, String password) {
    // TODO: implement createUserWithEmailandPassword
    throw UnimplementedError();
  }

  @override
  Future<MyUser> signInWithEmailandPassword(String email, String password) {
    // TODO: implement signInWithEmailandPassword
    throw UnimplementedError();
  }





}