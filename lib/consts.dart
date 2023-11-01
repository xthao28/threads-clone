import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const lightGreyColor = Color.fromRGBO(231, 232, 231, 1);
const backgroundColor = Colors.white10;
const grey = Colors.grey;

class FirebaseConst{
  static const String users = 'users';
  static const String threads = 'threads';
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

Widget circleAvatar(double radius, String url) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        // ignore: unnecessary_null_comparison
        backgroundImage: url != ''|| url != null ? NetworkImage(url) : null,
        radius: radius,
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