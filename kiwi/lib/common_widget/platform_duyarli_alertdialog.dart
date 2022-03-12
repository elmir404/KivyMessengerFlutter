import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiwi/common_widget/platform_duyarli_widget.dart';
class PlatformDuyarliAlertDialog extends PlatformDuyarliWidget{
  //concrete
  final String baslik;
  final String icerik;
  final String anaButtonyazisi;
  final String iptalButtonYazisi;

  PlatformDuyarliAlertDialog({@required this.baslik,@required this.icerik,@required this.anaButtonyazisi, this.iptalButtonYazisi});
  @override
  Widget buildAndroid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AlertDialog(title:Text(baslik),content: Text(icerik),actions: _dialogButtonlariniAyarla(context),),
    );
  }
 Future<bool> goster(BuildContext context) async{
  return Platform.isIOS ? showCupertinoDialog<bool>(context: context, builder: (context)=>this):
      await showDialog<bool>(context: context, builder: (context)=>this,barrierDismissible: false);
 }
  @override
  Widget buildIosWidget(BuildContext context) {
    return CupertinoAlertDialog(title:Text(baslik),content: Text(icerik),actions: _dialogButtonlariniAyarla(context),);

  }

 List<Widget> _dialogButtonlariniAyarla(BuildContext context) {
    final tumButtonlar =<Widget>[];
    if(Platform.isIOS){
      if(iptalButtonYazisi != null){
        tumButtonlar.add(CupertinoDialogAction(child: Text(iptalButtonYazisi),onPressed:(){Navigator.of(context).pop(false);},));
      }
        tumButtonlar.add(CupertinoDialogAction(child: Text(anaButtonyazisi),onPressed:(){Navigator.of(context).pop(true);},));
    }else{
      if(iptalButtonYazisi != null){
        tumButtonlar.add(TextButton(child: Text(iptalButtonYazisi),onPressed:(){Navigator.of(context).pop(false);},));
      }
      tumButtonlar.add( TextButton(onPressed: (){
        Navigator.of(context).pop(true);
      }, child: Text("Tamam")));

    }
    return tumButtonlar;
 }

}