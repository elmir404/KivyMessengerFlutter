import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItems{
  Users,Profil
}
class TabItemData{
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);
  static Map<TabItems,TabItemData> tumTablar ={
    TabItems.Users:TabItemData("Users",Icons.supervised_user_circle),
    TabItems.Profil:TabItemData("Profil",Icons.person),

  };
}