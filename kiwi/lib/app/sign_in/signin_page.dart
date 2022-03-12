import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/app/sign_in/email_password_login_save.dart';
import 'package:kiwi/common_widget/social_login_button.dart';
import 'package:kiwi/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // void _misafirGiris(BuildContext context) async {
  //   final _userModel = Provider.of<UserModel>(context, listen: false);
  //
  //   MyUser _user = await _userModel.signInAnonymously();
  //   if(_user != null) print("oturum acan user id:" + _user.userID.toString());
  // }

  void _signInWithGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    MyUser _user = await _userModel.signInWithGoogle();
    print("oturum acan user id:" + _user.userID.toString());
  }

  void _signInWithFacebook(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);

    MyUser _user = await _userModel.signInWithFacebook();
    print("oturum acan user id:" + _user.userID.toString());
  }

  void _emailandPasswordLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailAndPassworLoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kivi Messenger"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Daxil Ol",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              buttonText: "Sign In with Gmail",
              buttonColor: Colors.white,
              onPressed: () => _signInWithGoogle(context),
              textColor: Colors.black38,
              buttonIcon: Image.asset("images/gogle.png"),
            ),
            SocialLoginButton(
              buttonColor: Color(0xFF334D92),
              buttonText: "Sign In with Facebook",
              textColor: Colors.white,
              radius: 16,
              onPressed: () => _signInWithFacebook(context),
              buttonIcon: Image.asset("images/facebook.png"),
            ),
            SocialLoginButton(
              buttonText: "Sign in width Email",
              buttonIcon: Icon(
                Icons.email,
                size: 45,
                color: Colors.white,
              ),
              onPressed: () => _emailandPasswordLogin(context),
              buttonColor: Colors.teal,
            ),
            // SocialLoginButton(
            //   buttonText: "Guest",
            //   buttonIcon: Icon(
            //     Icons.account_circle_outlined,
            //     size: 45,
            //     color: Colors.white60,
            //   ),
            //   onPressed: () => _misafirGiris(context),
            //   buttonColor: Colors.blueGrey,
            // )
          ],
        ),
      ),
    );
  }
}
