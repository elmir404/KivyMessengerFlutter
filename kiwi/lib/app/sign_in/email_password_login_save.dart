
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/app/errror_exception.dart';
import 'package:kiwi/app/home_page.dart';
import 'package:kiwi/common_widget/platform_duyarli_alertdialog.dart';
import 'package:kiwi/common_widget/social_login_button.dart';
import 'package:kiwi/model/user.dart';
import 'package:kiwi/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
enum FormType{
  Register,Login
}
class EmailAndPassworLoginPage extends StatefulWidget {
  const EmailAndPassworLoginPage({Key key}) : super(key: key);

  @override
  _EmailAndPassworLoginPageState createState() => _EmailAndPassworLoginPageState();
}

class _EmailAndPassworLoginPageState extends State<EmailAndPassworLoginPage> {
  String _email,_sifre;
  String _buttonText,_linkText;
  var _formType=FormType.Login;
  final _formKey =GlobalKey<FormState>();
 void _formSubmit() async {
    _formKey.currentState.save();
    debugPrint("email:"+_email + " sifre:"+_sifre);
    final _userModel =Provider.of<UserModel>(context,listen: false);
    if(_formType ==FormType.Login ){
      try{
        MyUser _signinUser = await _userModel.signInWithEmailandPassword(_email, _sifre);
        if(_signinUser != null) print("oturum acan user id:" + _signinUser.userID.toString());
      }on FirebaseAuthException catch(e){
        PlatformDuyarliAlertDialog(baslik:"Xeta",icerik:Errors.goster(e.code),anaButtonyazisi:"Tamam",).goster(context);
      }


    }else{
      try{
        MyUser _createdUser = await _userModel.createUserWithEmailandPassword(_email, _sifre);
        if(_createdUser != null) print("oturum acan user id:" + _createdUser.userID.toString());
      }on FirebaseAuthException catch(e){
        debugPrint("Widget create user  hata:"+Errors.goster(e.code));
        PlatformDuyarliAlertDialog(baslik:"Xeta",icerik:Errors.goster(e.code),anaButtonyazisi:"Tamam",).goster(context);

      }
    }
  }
 void _change() {
   setState(() {
     _formType =_formType ==FormType.Login ? FormType.Register :FormType.Login;
   });
 }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType==FormType.Login ? "Sign In":"Sign Up";
    _linkText=_formType ==FormType.Login ? "Hesabiniz yoxdur? Qeydiyyat":"Hesabiniz var? Girish";

    final _userModel =Provider.of<UserModel>(context, listen: true);
    if(_userModel.state ==ViewState.Idle){
      if(_userModel.user != null){
        return HomePage(user: _userModel.user);

      }
    }
    else{
      return Center(child: CircularProgressIndicator(),);
    }


  return Scaffold(
      appBar: AppBar(

        title: Text("Sign in/Sign up"),
      ),
      body:_userModel.state ==ViewState.Idle ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    errorText: _userModel.emailErrorMessage !=null ? _userModel.emailErrorMessage:null,
                    prefixIcon: Icon(Icons.mail),
                    hintText: 'Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(),

                  ),

                  onSaved: (String savedEmail){
                    _email=savedEmail;
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _userModel.passwordErrorMessage !=null ? _userModel.passwordErrorMessage:null,
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    labelText: 'Password',
                    border: OutlineInputBorder(),

                  ),
                  onSaved: (String savedPassword){
                    _sifre=savedPassword;
                  },
                ),
                SizedBox(height: 10,),
                SocialLoginButton(
                  buttonText:_buttonText,
                buttonColor:Theme.of(context).primaryColor,
                  radius: 10,
                  onPressed:() => _formSubmit(),
                ),
                SizedBox(height: 10,),
                TextButton(onPressed:()=> _change(), child: Text(_linkText))
                
              ],
            ),
          ),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }


}

