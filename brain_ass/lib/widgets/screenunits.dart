import 'package:flutter/widgets.dart';

class ScreenSize{
 static late double width;
static  late double height;
static  initial(BuildContext context){
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
  }
}