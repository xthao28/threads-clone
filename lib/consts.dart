import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const lightGreyColor = Color.fromRGBO(231, 232, 231, 1);
const backgroundColor = Colors.white10;
const grey = Colors.grey;

class FirebaseConst{
  static const String users = 'users';
  static const String threads = 'threads';
  static const String comments = 'comments';
  static const String replies = 'replies';
}


class PageConst{
  static const String settingPage = 'setting-page';  
}

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

String formatTimestamp(Timestamp timestamp) {
  final now = DateTime.now();
  final postTime = timestamp.toDate(); // The timestamp should be in seconds

  final difference = now.difference(postTime);

  if (difference.inDays > 0) {
    if (difference.inDays >= 1 && difference.inDays < 2) {
      return 'Yesterday';
    } else {
      return '${postTime.day}/${postTime.month}/${postTime.year}';
    }
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m';
  } else if (difference.inSeconds > 0) {
    return '${difference.inSeconds}s';
  } else {
    return 'Just now';
  }
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


// Future<void> createThread(BuildContext context){
//   return showModalBottomSheet(
//     context: context, 
//     builder: (BuildContext context){
//       return Container(

//       )
//     }
//   );
// }