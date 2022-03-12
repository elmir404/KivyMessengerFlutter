import 'package:flutter/material.dart';
import 'package:kiwi/app/sign_in/signin_page.dart';
import 'package:kiwi/viewmodel/user_model.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

 final _userModel =Provider.of<UserModel>(context, listen: true);
 if(_userModel.state ==ViewState.Idle){
        if(_userModel.user == null){
          return SigninPage();

      }else{
         return HomePage(user:_userModel.user);
          }
    }
 else{
   return Scaffold(body:Center(child: CircularProgressIndicator()));
 }
  }

  }

