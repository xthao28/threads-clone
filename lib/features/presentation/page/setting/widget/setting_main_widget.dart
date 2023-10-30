import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/auth/auth_cubit.dart';

class SettingMainWidget extends StatelessWidget {
  final UserEntity currentUser;
  const SettingMainWidget({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        shadowColor: backgroundColor,        
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0,        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: lightGreyColor,
            thickness: 1,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                settingButton('Follow and invite friends', CupertinoIcons.person_crop_circle),
                settingButton('Notifications', CupertinoIcons.bell),
                settingButton('Your likes', CupertinoIcons.heart),
                settingButton('Privacy', CupertinoIcons.lock),
                settingButton('Account', CupertinoIcons.profile_circled),
                settingButton('Help', Icons.support_outlined),
                settingButton('About', CupertinoIcons.info)
              ],
            ),
          ),
          const Divider(
            color: lightGreyColor,
            thickness: 1,
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: (){}, 
                  child: const Text(
                    'Switch profiles',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue
                    ),
                  )
                ),
                TextButton(
                  onPressed: (){
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                    Navigator.pop(context);                                        
                  }, 
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red
                    ),
                  )
                ) 
              ]    
            ),
          ),                         
        ]
      )
    );
  }

  Widget settingButton(String text, IconData icon){
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            sizeHor(12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}