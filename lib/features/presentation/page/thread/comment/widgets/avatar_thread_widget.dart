import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';

import '../../../../../../consts.dart';
import '../../../../cubit/comment/comment_cubit.dart';

class AvatarThreadWidget extends StatefulWidget {
  final ThreadEntity thread;
  const AvatarThreadWidget({super.key, required this.thread});

  @override
  State<AvatarThreadWidget> createState() => _AvatarThreadWidgetState();
}

class _AvatarThreadWidgetState extends State<AvatarThreadWidget> {
  @override
  void initState() {
    BlocProvider.of<CommentCubit>(context).readComments(threadId: widget.thread.threadId!);    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, commentState){
        if(commentState is CommentLoaded){
          final comments = commentState.comment;
          // print(comments);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,                
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: grey,
                backgroundImage: NetworkImage(widget.thread.userProfileUrl!),
              ),
              sizeVer(6),
              comments.isEmpty ? Container()  
              : const Expanded(
                child: VerticalDivider(
                  width: 1,
                  thickness: 2,
                  color: lightGreyColor,
                ),
              ),
              sizeVer(6),
              SizedBox(
                width: 30,
                child: comments.length >= 2 ? 
                Stack(
                  children: [
                    Positioned(
                      child: stackCircleAvatar(7, Colors.blue, comments[0].userProfileUrl!)
                    ),
                    Positioned(
                      left: 12,
                      child: stackCircleAvatar(7, Colors.red, comments[1].userProfileUrl!)
                    ),
                  ],
                ) 
                : comments.length == 1 ?
                stackCircleAvatar(8, Colors.grey, comments[0].userProfileUrl!)
                : Container(),
              )
            ],
          );
        }
        return Container();
      }
    );
  }
  Widget stackCircleAvatar(double radius, Color backgroundColor, String url){
    return CircleAvatar(
      radius: radius + 3,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}