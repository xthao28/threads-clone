import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_followers/get_followers_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/widgets/activity_main_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;

import '../../cubit/user/get_following/get_following_cubit.dart';

class ActivityPage extends StatefulWidget {  
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: FirebaseAuth.instance.currentUser!.uid);
    super.initState();    
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<GetFollowersCubit>()),
        BlocProvider(create: (_) => di.sl<GetFollowingCubit>()),
      ],
      child: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, userState){          
          if(userState is GetSingleUserLoaded){
            final currentUser = userState.user;
            return ActivityMainWidget(currentUser: currentUser);
          }
          return Center(child: circularIndicatorThreads(),);
        }
      ),
    );
  }
}