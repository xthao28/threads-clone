import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/app_entity.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_single_thread/read_single_thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';

class ThreadDetailMainWidget extends StatefulWidget {
  final AppEntity appEntity;
  const ThreadDetailMainWidget({super.key, required this.appEntity});

  @override
  State<ThreadDetailMainWidget> createState() => _ThreadDetailMainWidgetState();
}

class _ThreadDetailMainWidgetState extends State<ThreadDetailMainWidget> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.appEntity.currentUid!);
    BlocProvider.of<ReadSingleThreadCubit>(context).getSingleThread(threadId: widget.appEntity.threadId!);
    BlocProvider.of<CommentCubit>(context).readComments(threadId: widget.appEntity.threadId!);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}