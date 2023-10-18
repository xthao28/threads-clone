import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const lightGreyColor = Color.fromRGBO(231, 232, 231, 1);
const backgroundColor = Colors.white10;



Widget sizeVer(double height){
  return SizedBox(height: height,);
}

Widget sizeHor(double width){
  return SizedBox(width: width,);
}

class FirebaseConst{
  static const String users = 'users';
  static const String threads = 'threads';
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