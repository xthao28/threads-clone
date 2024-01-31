import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/page/thread/widgets/single_card_thread_widget.dart';

import '../../../cubit/comment/comment_cubit.dart';

class CommentPage extends StatefulWidget {
  final ThreadEntity thread;
  const CommentPage({super.key, required this.thread});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    BlocProvider.of<CommentCubit>(context).readComments(threadId: widget.thread.threadId!);    
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleCardThreadWidget(thread: widget.thread),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index){          
                        return Text(comments[index].description!);
                      },              
                    ),
                  ),
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