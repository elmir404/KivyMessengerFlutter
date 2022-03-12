
import 'dart:io';

import 'package:flutter/material.dart';
abstract class  PlatformDuyarliWidget extends StatelessWidget{
Widget buildAndroid(BuildContext context);
Widget buildIosWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildIosWidget(context);
    }
    return buildAndroid(context);
  }

}