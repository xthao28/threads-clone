
import 'package:flutter/material.dart';
import 'package:threads_clone/utils/consts.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/setting/setting_page.dart';

class OnGenerateRoute {
  // ignore: body_might_complete_normally_nullable
  static Route<dynamic>? route(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case PageConst.settingPage: {
        if(args is UserEntity){
          return routeBuilder(SettingPage(currentUser: args));
        }else{
          return routeBuilder( const NoPagefound());
        }
      }
      default: {
        const NoPagefound();
      }     
    }    
  }
}

dynamic routeBuilder(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}

class NoPagefound extends StatelessWidget {
  const NoPagefound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No Page Found!'),
      ),
    );
  }
}