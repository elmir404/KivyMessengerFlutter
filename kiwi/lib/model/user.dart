
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyUser{
  final String userID;
  String email;
  String userName;
  String profilUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int level;

  MyUser({@required this.userID,@required this.email});
Map<String,dynamic> toMap(){
return {
'userID':userID,
  'email':email,
  'userName':userName ?? email.substring(0,email.indexOf('@')) +randomNumberGenerator(),
  'profilUrl':profilUrl ?? ' ',
  'updatedAt':updatedAt ?? FieldValue.serverTimestamp(),
  'createdAt':createdAt ?? FieldValue.serverTimestamp(),
  'level':level ?? 1,

};
}
MyUser.fromMap(Map<String,dynamic> map):
      userID =map['userID'],
      email =map['email'],
      userName =map['userName'],
      profilUrl =map['profilUrl'] ,
      updatedAt =(map['updatedAt'] as Timestamp).toDate(),
      createdAt =(map['createdAt'] as Timestamp).toDate(),
      level =map['level'];

  @override
  String toString() {
    return 'MyUser{userID: $userID, email: $email, userName: $userName, profilUrl: $profilUrl, createdAt: $createdAt, updatedAt: $updatedAt, level: $level}';
  }

  String randomNumberGenerator() {
    int rastgeleSayi =Random().nextInt(999999);
    return rastgeleSayi.toString();
  }
}