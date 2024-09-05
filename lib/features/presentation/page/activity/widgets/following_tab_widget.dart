import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_following/get_following_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/widgets/single_card_user_follow_widget.dart';

import '../../../../../utils/widgets.dart';

class FollowingTabWidget extends StatefulWidget {
  final UserEntity currentUser;
  const FollowingTabWidget({super.key, required this.currentUser});

  @override
  State<FollowingTabWidget> createState() => _FollowingTabWidgetState();
}

class _FollowingTabWidgetState extends State<FollowingTabWidget> {
  @override
  void initState() {
    BlocProvider.of<GetFollowingCubit>(context).getFollowing(listFollowing: widget.currentUser.following as List<dynamic>);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFollowingCubit, GetFollowingState>(
      builder: (context, userState){
        if(userState is GetFollowingLoaded){
          final userFollowers = userState.users;
          return userFollowers.isEmpty ?
          nothingToSeeHereYet() :
          ListView.builder(
            itemCount: userFollowers.length,
            itemBuilder: (context, index) {              
              final userFollower = userFollowers[index];                            
              return SingleCardUserFollowWidget(
                otherUser: userFollower,
                currentUser: widget.currentUser,
                isFollowers: false,
              );
            },
          );
        }
        return Center(child: circularIndicatorThreads(),);        
      }
    );
  }
}