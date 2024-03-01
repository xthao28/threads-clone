import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_followers/get_followers_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/widgets/single_card_user_follow_widget.dart';

import '../../../../../utils/widgets.dart';

class FollowersTabWidget extends StatefulWidget {
  final UserEntity currentUser;
  const FollowersTabWidget({super.key, required this.currentUser});

  @override
  State<FollowersTabWidget> createState() => _FollowersTabWidgetState();
}

class _FollowersTabWidgetState extends State<FollowersTabWidget> {
  @override
  void initState() {
    BlocProvider.of<GetFollowersCubit>(context).getFollowers(listFollowers: widget.currentUser.followers as List<dynamic>);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFollowersCubit, GetFollowersState>(
      builder: (context, userState){
        // if(userState is GetFollowersFailure){
        //   return nothingToSeeHereYet();
        // }
        if(userState is GetFollowersLoaded){
          final userFollowers = userState.users;
          return userFollowers.isEmpty ?
          nothingToSeeHereYet() :
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ListView.builder(
              itemCount: userFollowers.length,
              itemBuilder: (context, index) {              
                final userFollower = userFollowers[index];                            
                return SingleCardUserFollowWidget(
                  otherUser: userFollower,
                  currentUser: widget.currentUser,
                );
              },
            ),
          );
        }
        return Center(child: circularIndicatorThreads(),);
      }
    );
  }
}