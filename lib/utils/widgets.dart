import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

Widget sizeVer(double height){
  return SizedBox(height: height,);
}

Widget sizeHor(double width){
  return SizedBox(width: width,);
}

Widget titlePage(String title){
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16
    ),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}

Widget text(String text, double fontSize, FontWeight fontWeight, Color color ){
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color
    ),
  );
}

Widget labelTab(String text){
  return Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16
    ),
  );
}

Widget customMessage(String message){
  return Center(
    child: Text(
      message,
      style: const TextStyle(
        color: grey,
        fontSize: 14
      ),
    )
  );
}

Widget avatarUser(double position, double borderRadius, double radiusCircle, Color color){
  return Positioned(
    left: position,
    child: CircleAvatar(
      radius: borderRadius,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radiusCircle,
        backgroundColor: color
      ),
    ),
  );
}

Widget circularIndicatorThreads(){
  return Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator();
}

Widget circleAvatar(double radius, String url) {
  return CircleAvatar(
    backgroundColor: Colors.grey,
    // ignore: unnecessary_null_comparison
    backgroundImage: url != ''|| url != null ? NetworkImage(url) : null,
    radius: radius,
  );
}

Widget iconFile(String nameFile){
  return Padding(
    padding: const EdgeInsets.only(right: 18),
    child: Image.asset(
      'assets/images/$nameFile.png',
      width: 22.5,
    ),
  );
}

Widget nothingToSeeHereYet(){
    return const Center(
      child: Text(
        "Nothing to see here yet",
        style: TextStyle(
          color: grey,
          fontSize: 14
        ),
      )
    );
  }

  void toast(String message, Color color){  
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: color == Colors.red ? ToastGravity.TOP : ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16
  );
}

void customToast(BuildContext context){
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container();
  FToast().showToast(
    child: toast,
    toastDuration: const Duration(seconds: 2),
  );
}

Future showMyModalBottomSheet(BuildContext context, Widget childWidget){
  return showModalBottomSheet(  
    isScrollControlled: true,   
    useRootNavigator: true,                     
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      )
    ),
    context: context, 
    builder: (BuildContext context){
      return childWidget;
    }
  );
}
