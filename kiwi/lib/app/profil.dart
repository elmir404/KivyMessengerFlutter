import 'package:flutter/material.dart';
import 'package:kiwi/common_widget/platform_duyarli_alertdialog.dart';
import 'package:kiwi/viewmodel/user_model.dart';
import 'package:provider/provider.dart';
class ProfilPage extends StatelessWidget {
  const ProfilPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel _userModel=Provider.of<UserModel>(context);
    print("user sehifesideki degerler:"+_userModel.user.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Profil"),actions: <Widget>[
        TextButton(onPressed:()=> _cikisUcunTesdiq(context), child: Text("Log out",style: TextStyle(color: Colors.white60,fontSize: 18),))
      ],),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            children: <Widget>[
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(_userModel.user.profilUrl),
              )
            ],

          )
        ),
      ),
    );
  }
  Future<bool> _cikisYap(BuildContext context)async {
  final _userModel =Provider.of<UserModel>(context, listen: false);

 bool sonuc= await _userModel.signOut();
  return sonuc;

 }

 Future _cikisUcunTesdiq(BuildContext context) async {
   final sonuc= await PlatformDuyarliAlertDialog(baslik: "Eminsiniz?",icerik: "Cixmaq istediyinizden eminsiniz?",anaButtonyazisi: "Yes",iptalButtonYazisi: "NO",).goster(context);
   if(sonuc == true){
     _cikisYap(context);
   }
 }
}