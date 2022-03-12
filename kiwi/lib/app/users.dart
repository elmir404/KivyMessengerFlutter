import 'package:flutter/material.dart';
class UsersPage extends StatelessWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users"),actions: <Widget>[

      ],),
      body: Center(child: Text("Users Page"),),
    );
  }
}
