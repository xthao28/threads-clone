import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_single_thread/read_single_thread_cubit.dart';
import 'package:threads_clone/features/presentation/page/thread/comment/widgets/card_thread_detail_widget.dart';
import 'package:threads_clone/features/presentation/page/thread/comment/widgets/single_card_comment_widget.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';
import '../../../cubit/comment/comment_cubit.dart';

class CommentPage extends StatefulWidget {
  final ThreadEntity thread;
  final String currentUid;
  const CommentPage({super.key, required this.thread, required this.currentUid});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    BlocProvider.of<CommentCubit>(context).readComments(threadId: widget.thread.threadId!);       
    BlocProvider.of<ReadSingleThreadCubit>(context).getSingleThread(threadId: widget.thread.threadId!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentCubit, CommentState>(
      builder: (context, commentState) {
        if(commentState is CommentLoaded){
          final comments = commentState.comment;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              title: text('Thread', 16.0, FontWeight.bold, textColorNormal)              
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ReadSingleThreadCubit, ReadSingleThreadState>(
                    builder: (context, threadState){
                      if(threadState is ReadSingleThreadLoaded){
                        return CardThreadDetailwidget(thread: threadState.thread, currentUid: widget.currentUid);
                      }
                      return circularIndicatorThreads();
                    }
                  ),
                  Column(
                    children: comments.map((comment) => SingleCardCommentWidget(comment: comment, currentUid: widget.currentUid)).toList(),
                  )
                ],
              ),
            ),
          );
        }
        return circularIndicatorThreads();
      }
    );
  }
}