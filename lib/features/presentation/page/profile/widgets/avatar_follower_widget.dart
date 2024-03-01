import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

import '../../../../../utils/widgets.dart';
import '../../../cubit/user/get_followers/get_followers_cubit.dart';

class AvatarFollowerWidget extends StatefulWidget {
  final UserEntity currentUser;
  const AvatarFollowerWidget({super.key, required this.currentUser});

  @override
  State<AvatarFollowerWidget> createState() => _AvatarFollowerWidgetState();
}

class _AvatarFollowerWidgetState extends State<AvatarFollowerWidget> {

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
          Container() :
          SizedBox(
            width: 50,            
            child: Stack(
              children: [
                userFollowers.isNotEmpty ? Positioned(
                  child: stackAvatar(userFollowers[0].profileUrl!)
                ) : Container(),                
                userFollowers.length > 1 ? Positioned(
                  left: 12,
                  child: stackAvatar(userFollowers[1].profileUrl!)
                ) : Container(),                
                userFollowers.length > 2 ? Positioned(
                  left: 24,
                  child: stackAvatar(userFollowers[2].profileUrl!)
                ) : Container()
              ],
            ),
          );
        }
        return Center(child: circularIndicatorThreads(),);
      }
    );
  }
  Widget stackAvatar(String url){
    return CircleAvatar(
      radius: 11,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 9,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}