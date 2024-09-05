import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/utils/consts.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/page/thread/comment/create_comment.dart';
import 'package:threads_clone/features/presentation/page/profile/profile_page.dart';
import 'package:threads_clone/features/presentation/page/profile/single_user_profile_page.dart';
import 'package:threads_clone/features/presentation/page/thread/widgets/like_thread_animation_widget.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/widgets.dart';
import '../../like/like_page.dart';

class CardThreadDetailwidget extends StatefulWidget {
  final ThreadEntity thread;
  final String currentUid;
  
  const CardThreadDetailwidget({super.key, required this.thread, required this.currentUid});
  
  @override
  State<CardThreadDetailwidget> createState() => _CardThreadDetailwidgetState();
}

class _CardThreadDetailwidgetState extends State<CardThreadDetailwidget> {

  @override
  Widget build(BuildContext context) {    
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [                    
          Expanded(
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,                                   
              children: [
                Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                    
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: grey,
                          backgroundImage: NetworkImage(widget.thread.userProfileUrl!),
                        ), 
                        sizeHor(10), 
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => widget.currentUid == widget.thread.creatorUid ?
                                const ProfilePage() :
                                SingleUserProfilePage(otherUserId: widget.thread.creatorUid.toString())
                              )
                            );
                          },
                          child: text(widget.thread.username!, 16.0, FontWeight.bold, textColorNormal)                          
                        ),
                      ],
                    ),
                    Row(                          
                      children: [
                        Text(
                          formatTimestamp(widget.thread.createdAt!),                              
                          style: const TextStyle(
                            color: grey,
                          ),
                        ),
                        sizeHor(5),
                        if(widget.currentUid == widget.thread.creatorUid)
                          InkWell(
                            onTap: _showOption,                                                              
                            child: const Icon(
                              Icons.more_horiz
                            ),
                          )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(                        
                    widget.thread.description!,                                                    
                    overflow: TextOverflow.clip,                          
                    style: const TextStyle(
                      fontSize: 16,                            
                    ),                        
                  ),
                ), 
                widget.thread.threadImageUrl != '' ? 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),                        
                    child: CachedNetworkImage(
                      imageUrl: widget.thread.threadImageUrl!,
                      placeholder: (context, url) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),                              
                        width: double.maxFinite, 
                        height: 200,                         
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                      ),                            
                    )
                  ),
                ) : 
                Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: LikeThreadAnimationWidget(
                          isLike: widget.thread.likes!.contains(widget.currentUid), 
                          thread: widget.thread,                         
                        )
                      ),
                      InkWell(
                        onTap:() => showMyModalBottomSheet(
                          context, 
                          CreateComment(thread: widget.thread, currentUid: widget.currentUid)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Image.asset(
                            'assets/images/reply.png',
                            width: 22.5,
                          ),
                        ),
                      ),
                      iconFile('repost'),
                      iconFile('paperplane')
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(widget.thread.totalComments! > 0)
                      text('${widget.thread.totalComments} replies', 16.0, FontWeight.normal, grey),
                    if(widget.thread.totalComments! > 0 && widget.thread.totalLikes! > 0)
                      text(' · ', 20.0, FontWeight.bold, grey),                          
                    if(widget.thread.totalLikes! > 0)
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LikePage(thread: widget.thread, currentUserUid: widget.currentUid,)));
                        },
                        child: text('${widget.thread.totalLikes} likes', 16.0, FontWeight.normal, grey)
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _showOption(){
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      context: context, 
      builder: (BuildContext context){
        return FractionallySizedBox(
          heightFactor: 0.15,
          child: Container(
            padding: const EdgeInsets.only(
              top: 7,
              left: 16,
              right: 16,              
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5/2),
                    color: grey
                  ),
                ),
                sizeVer(15),
                InkWell(
                  splashColor: backgroundColor,
                  onTap: _deleteThread,
                  child: Container(                                      
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Icon(
                            CupertinoIcons.delete,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  _deleteThread(){
    BlocProvider.of<ThreadCubit>(context).deleteThread(
      thread: ThreadEntity(
        threadId: widget.thread.threadId
      )
    );
  }
}