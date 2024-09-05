import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/get_likes/get_likes_cubit.dart';
import 'package:threads_clone/features/presentation/page/search/widget/single_card_user_widget.dart';
import 'package:threads_clone/utils/widgets.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/consts.dart';
import '../../../profile/profile_page.dart';
import '../../../profile/single_user_profile_page.dart';

class LikeMainWidget extends StatefulWidget {
  final ThreadEntity thread;
  final String currentUserUid;
  const LikeMainWidget({super.key, required this.thread, required this.currentUserUid});

  @override
  State<LikeMainWidget> createState() => _LikeMainWidgetState();
}

class _LikeMainWidgetState extends State<LikeMainWidget> {
  @override
  void initState() {
    BlocProvider.of<GetLikesCubit>(context).getLikes(listLikes: widget.thread.likes!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: text('Post activity', 18.0, FontWeight.bold, textColorNormal)              
      ),
      body: BlocBuilder<GetLikesCubit, GetLikesState>(
        builder: (context, userState){
          if(userState is GetLikesLoaded){
            final users = userState.listUsers;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: lightGreyColor
                        ),
                        borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    circleAvatar(10, widget.thread.userProfileUrl!),
                                    sizeHor(10),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => widget.currentUserUid == widget.thread.creatorUid ?
                                            const ProfilePage() :
                                            SingleUserProfilePage(otherUserId: widget.thread.creatorUid.toString())
                                          )
                                        );
                                      },
                                      child: text(widget.thread.username!, 16.0, FontWeight.bold, textColorNormal)                            
                                    ),
                                  ],
                                ),
                                Text(
                                  formatTimestamp(widget.thread.createdAt!),                              
                                  style: const TextStyle(
                                    color: grey,
                                  ),
                                ),
                              ],
                            ),
                            sizeVer(8),
                            Text(
                              widget.thread.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    sizeVer(20),
                    Column(
                      children: users.map((user) => SingleCardUserWidget(currentUser: user)).toList(),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: circularIndicatorThreads(),);
        }
      )
    );
  }
}