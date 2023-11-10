import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/profile_main_widget.dart';

import '../../../../consts.dart';
import '../../cubit/user/get_single_user/get_single_user_cubit.dart';


class ProfilePage extends StatefulWidget {
  // final String uid;
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: FirebaseAuth.instance.currentUser!.uid);        
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserSate) {
        if(getSingleUserSate is GetSingleUserLoaded){
          final currentUser = getSingleUserSate.user;
          return ProfileMainWidget(currentUser: currentUser,); 
        }
        return Scaffold(body: Center(child: circularIndicatorThreads()));
      }
    );
  }
}