
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:kiwi/model/user.dart';
import 'package:kiwi/services/auth_base.dart';

class FirebaseAuthService implements AuthBase{

  final  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  @override
  Future<MyUser> getcurrentUser() async {
    try{
      User user = await _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    }catch(e){
      print("Hata current user"+e.toString());
      return null;
    }

  }
MyUser _userFromFirebase(User user){
    if(user == null) {
      return null;
    }
      return MyUser(userID: user.uid,email: user.email);

}
  @override
  Future<MyUser> signInAnonymously() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    }catch(e){
      print("anonimgiris xeta"+e.toString());
        return null;
    }
  }

  @override
  Future<bool> signOut()async {
    try{
      final _googleSignIn =GoogleSignIn();
        await _googleSignIn.signOut();
      final _facebookLogin =FacebookLogin();
      await _facebookLogin.logOut();
      await _firebaseAuth.signOut();
        return true;
    }catch(e){
      print("sign out"+e.toString());
      return false;
    }
  }

  @override
  Future<MyUser> signInWithGoogle()async {
   GoogleSignIn _googleSignIn =GoogleSignIn();
   GoogleSignInAccount _googleUser =await _googleSignIn.signIn();
   if(_googleUser != null){
     GoogleSignInAuthentication _googleAuth =await _googleUser.authentication;
     if(_googleAuth.idToken != null && _googleAuth.accessToken != null){
       final sonuc= await _firebaseAuth.signInWithCredential(
         GoogleAuthProvider.credential(idToken:_googleAuth.idToken,accessToken: _googleAuth.accessToken)
       );
       User _user =sonuc.user;
       return _userFromFirebase(_user);
     }else{
       return null;
     }
   }else{
     return null;
   }
  }

  @override
  Future<MyUser> signInWithFacebook() async{
    final _facebookLogin = FacebookLogin();
    FacebookLoginResult _faceResult = await _facebookLogin.logIn(['public_profile', 'email']);
    switch(_faceResult.status){
      case FacebookLoginStatus.loggedIn:
        if (_faceResult.accessToken != null &&
            _faceResult.accessToken.isValid()) {
          var _firebaseResult = await _firebaseAuth.signInWithCredential(FacebookAuthProvider.credential(_faceResult.accessToken.token));
          User _user = _firebaseResult.user;
          return _userFromFirebase(_user);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("kullanici facebook girisi iptal etdi");
        break;
      case FacebookLoginStatus.error:
        print("xeta bas verdi:"+_faceResult.errorMessage);
        break;

    }
  }

  @override
  Future<MyUser> createUserWithEmailandPassword(String email, String password)async {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);

  }

  @override
  Future<MyUser> signInWithEmailandPassword(String email, String password)async {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);

  }





}