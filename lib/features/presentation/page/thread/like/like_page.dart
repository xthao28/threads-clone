import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/get_likes/get_likes_cubit.dart';
import 'package:threads_clone/features/presentation/page/thread/like/widgets/like_main_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;

class LikePage extends StatelessWidget {
  final ThreadEntity thread;
  final String currentUserUid;
  const LikePage({super.key, required this.thread, required this.currentUserUid});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<GetLikesCubit>())
      ], 
      child: LikeMainWidget(thread: thread, currentUserUid: currentUserUid,)
    );
  }
}