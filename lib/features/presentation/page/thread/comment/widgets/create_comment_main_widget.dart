import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:uuid/uuid.dart';

class CreateCommentMainWidget extends StatefulWidget {
  final ThreadEntity thread;
  final String currentUid;
  const CreateCommentMainWidget({super.key, required this.thread, required this.currentUid});

  @override
  State<CreateCommentMainWidget> createState() => _CreateCommentMainWidgetState();
}

class _CreateCommentMainWidgetState extends State<CreateCommentMainWidget> {

  final TextEditingController _descriptionController = TextEditingController();


  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.currentUid);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double checkKeyBoard = MediaQuery.of(context).viewInsets.bottom;
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, userState){
        if(userState is GetSingleUserLoaded){
          final currentUser = userState.user;
          return Container(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: lightGreyColor
                      )
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',            
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            ),              
                          ),
                        ),
                        const Text(
                          'Reply',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        InkWell(
                          onTap:() => createComment(user: currentUser), 
                          child: const Text(
                            'Post',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: checkKeyBoard == 0 ? height*0.8 : height*0.45,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,                
                                  children: [
                                    CircleAvatar(
                                      radius: 19,
                                      backgroundColor: grey,
                                      backgroundImage: NetworkImage(widget.thread.userProfileUrl!),
                                    ),
                                    sizeVer(6),
                                    const Expanded(
                                      child: VerticalDivider(
                                        width: 1,
                                        thickness: 2,
                                        color: lightGreyColor,
                                      ),
                                    ),
                                    sizeVer(6),                                  
                                  ],
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
                                            Text(
                                              widget.thread.username!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                              ),
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
                                          padding: const EdgeInsets.only(
                                            top: 6,
                                            bottom: 15
                                          ),
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
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,                
                                  children: [
                                    CircleAvatar(
                                      radius: 19,
                                      backgroundColor: grey,
                                      backgroundImage: NetworkImage(currentUser.profileUrl!),
                                    ),
                                    sizeVer(6),
                                    const Expanded(
                                      child: VerticalDivider(
                                        width: 1,
                                        thickness: 2,
                                        color: lightGreyColor,
                                      ),
                                    ),
                                    sizeVer(6),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: grey,
                                      backgroundImage: NetworkImage(currentUser.profileUrl!),
                                    ),                                  
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column( 
                                      crossAxisAlignment: CrossAxisAlignment.start,                                   
                                      children: [
                                        Text(
                                          currentUser.username!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                          ),
                                        ),  
                                        TextFormField(                                                                         
                                          controller: _descriptionController,                                                                                                    
                                          keyboardType: TextInputType.multiline, 
                                          maxLines: null,                                                                  
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: 'Reply to ${widget.thread.username!}...',
                                            border: InputBorder.none
                                          ),  
                                        ),
                                        sizeVer(10),
                                        const Text(
                                          'Add another reply',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: grey
                                          ),
                                        )                                                                                                   
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: circularIndicatorThreads(),);
      }
    );
  }

  Future<void> createComment({required UserEntity user}) async{
    BlocProvider.of<CommentCubit>(context).createComment(
      comment: CommentEntity(
        commentId: const Uuid().v1(), 
        threadId: widget.thread.threadId, 
        creatorUid: user.uid, 
        description: _descriptionController.text, 
        username: user.username, 
        userProfileUrl: user.profileUrl, 
        createdAt: Timestamp.now(), 
        likes: const [], 
        totalReplies: 0
      )
    ).then((value) {
      setState(() {
        _descriptionController.clear();
      });
    }).then((value) => Navigator.pop(context));    
  }
}

