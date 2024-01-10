import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/app_entity.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_single_thread/read_single_thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/thread/widgets/thread_detail_main_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;


class ThreadDetailPage extends StatelessWidget {
  final AppEntity appEntity;
  const ThreadDetailPage({super.key, required this.appEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<ReadSingleThreadCubit>()),
        BlocProvider(create: (_) => di.sl<CommentCubit>())
      ], 
      child: ThreadDetailMainWidget(appEntity: appEntity)
    );
  }
}