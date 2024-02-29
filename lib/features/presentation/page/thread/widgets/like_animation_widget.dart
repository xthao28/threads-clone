import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/comment/comment_entity.dart';
import '../../../../domain/entities/thread/thread_entity.dart';
import '../../../cubit/comment/comment_cubit.dart';
import '../../../cubit/thread/thread_cubit.dart';

class LikeAnimationWidget extends StatefulWidget {  
  final bool isLike;
  final ThreadEntity thread;
  final CommentEntity comment;
  final bool isThread;
  const LikeAnimationWidget({super.key, required this.isLike, required this.thread, required this.comment, required this.isThread});

  @override
  State<LikeAnimationWidget> createState() => _LikeAnimationWidgetState();
}

class _LikeAnimationWidgetState extends State<LikeAnimationWidget> with SingleTickerProviderStateMixin {

  bool? _isLike;
  AnimationController? _controller;
  Animation<double>? _sizeAnimation;

  @override
  void initState() {
    _isLike = widget.isLike;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this
    );

    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 22.5,
            end: 23.5
          ), 
          weight: 23.5
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 23.5,
            end: 22.5
          ), 
          weight: 23.5
        )
      ]
    ).animate(_controller!);    
    _controller!.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          _isLike = true;
        });
      }
      if(status == AnimationStatus.dismissed){
        setState(() {
          _isLike = false;
        });
      }
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (BuildContext context, _){
        return GestureDetector(
          onTap: widget.isThread ? _likeThread : _likeComment,
          child: Image.asset(
            'assets/images/${widget.isLike ? 'heart-red' : 'like'}.png',
            width: _sizeAnimation!.value,       
          ),
        );
      },
    );
  }
  _likeThread(){
    BlocProvider.of<ThreadCubit>(context).likeThread(
      thread: ThreadEntity(
        threadId: widget.thread.threadId
      )
    );  
    _isLike! ? _controller!.reverse() : _controller!.forward();  
  }
  _likeComment(){
    BlocProvider.of<CommentCubit>(context).likeComment(
      comment: CommentEntity(
        threadId: widget.comment.threadId,
        commentId: widget.comment.commentId,
      )
    ); 
    _isLike! ? _controller!.reverse() : _controller!.forward(); 
  }
}