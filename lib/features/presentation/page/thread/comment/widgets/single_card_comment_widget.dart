import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/consts.dart';
import '../../../../../../utils/widgets.dart';
import '../../../../../domain/entities/comment/comment_entity.dart';
import '../../../profile/profile_page.dart';
import '../../../profile/single_user_profile_page.dart';
import '../../widgets/like_animation_widget.dart';

class SingleCardCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final String currentUid;
  const SingleCardCommentWidget({super.key, required this.comment, required this.currentUid});

  @override
  State<SingleCardCommentWidget> createState() => _SingleCardCommentWidgetState();
}

class _SingleCardCommentWidgetState extends State<SingleCardCommentWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: lightGreyColor,)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12
        ),
        child: Row(          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 19,
              backgroundColor: grey,
              backgroundImage: NetworkImage(widget.comment.userProfileUrl!),
            ),              
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,                                   
                  children: [
                    Row(  
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,                    
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => widget.currentUid == widget.comment.creatorUid ?
                                const ProfilePage() :
                                SingleUserProfilePage(otherUserId: widget.comment.creatorUid.toString())
                              )
                            );
                          },
                          child: text(widget.comment.username!, 16.0, FontWeight.bold, textColorNormal)                          
                        ),
                        Row(                          
                          children: [
                            Text(
                              formatTimestamp(widget.comment.createdAt!),                              
                              style: const TextStyle(
                                color: grey,
                              ),
                            ),
                            sizeHor(5),
                            if(widget.currentUid == widget.comment.creatorUid)
                              const InkWell(
                                // onTap: _showOption,                                                              
                                child: Icon(
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
                        widget.comment.description!,                                                    
                        overflow: TextOverflow.clip,                          
                        style: const TextStyle(
                          fontSize: 16,                            
                        ),                        
                      ),
                    ),                     
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: LikeAnimationWidget(
                              isLike: widget.comment.likes!.contains(widget.currentUid), 
                              thread: const ThreadEntity(),
                              comment: widget.comment,
                              isThread: false,
                            )
                          ),
                          InkWell(
                            // onTap: _createComment,
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
                        text('${widget.comment.totalReplies} replies', 16, FontWeight.normal, grey),
                        text(' · ', 20, FontWeight.bold, grey),                                     
                        text('${widget.comment.totalLikes} likes', 16, FontWeight.normal, grey),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }  
}
