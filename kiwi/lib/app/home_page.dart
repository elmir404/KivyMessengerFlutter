
import 'package:flutter/material.dart';
import 'package:kiwi/app/my_custom_bootom_navi.dart';
import 'package:kiwi/app/profil.dart';
import 'package:kiwi/app/tab_items.dart';
import 'package:kiwi/app/users.dart';


import '../model/user.dart';
class HomePage extends StatefulWidget {
final MyUser user;
   HomePage({Key key,@required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<TabItems,GlobalKey<NavigatorState>> navigatorKeys= {
TabItems.Users :GlobalKey<NavigatorState>(),
    TabItems.Profil :GlobalKey<NavigatorState>(),


  };
  TabItems _currentTab =TabItems.Users;
  Map<TabItems,Widget> allPages(){
    return{
      TabItems.Users:UsersPage(),
      TabItems.Profil:ProfilPage()
    };
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(onWillPop: () async =>!await navigatorKeys[_currentTab].currentState.maybePop(),child: MyCustomBottomNavigation(pageCreater: allPages(),currentTab: _currentTab,navigatorKeys:navigatorKeys,onSelectedTab: (selectedTab){
      if(selectedTab == _currentTab){
        navigatorKeys[selectedTab].currentState.popUntil((route) => route.isFirst);
      }else{
        setState(() {
          _currentTab=selectedTab;
        });
      }

    },),


    );
  }


}
