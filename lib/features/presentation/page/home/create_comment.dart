import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/home/widget/create_comment_main_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;

class CreateComment extends StatelessWidget {
  final ThreadEntity thread; 
  final String currentUid;
  const CreateComment({super.key, required this.thread, required this.currentUid});

  @override
   build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<CommentCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>())
      ], 
      child: CreateCommentMainWidget(thread: thread, currentUid: currentUid,)
    );
  }
}