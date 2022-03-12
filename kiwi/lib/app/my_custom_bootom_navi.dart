import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/app/tab_items.dart';
class MyCustomBottomNavigation extends StatelessWidget {

final TabItems currentTab;
final ValueChanged<TabItems> onSelectedTab;
final Map<TabItems,Widget> pageCreater;
final Map<TabItems,GlobalKey<NavigatorState>> navigatorKeys;


  const MyCustomBottomNavigation({Key key,@required this.currentTab,@required this.onSelectedTab ,@required this.pageCreater,@required this.navigatorKeys}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(tabBar: CupertinoTabBar(items: [
    _navItemOlustur(TabItems.Users),
      _navItemOlustur(TabItems.Profil),

    ],
    onTap: (index)=>onSelectedTab(TabItems.values[index]),), tabBuilder: (context,index){

      final showItem=TabItems.values[index];
 return CupertinoTabView(
 navigatorKey: navigatorKeys[showItem],builder: (context){
   return pageCreater[showItem];
 },);
    });
  }
  BottomNavigationBarItem _navItemOlustur(TabItems tabItem){
    final curentTab = TabItemData.tumTablar[tabItem];
 return BottomNavigationBarItem(icon:Icon(curentTab.icon) ,label:curentTab.title,);

  }
}
