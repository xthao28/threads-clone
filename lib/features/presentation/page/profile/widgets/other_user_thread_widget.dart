import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';

import '../../../../../consts.dart';
import 'package:threads_clone/injection_container.dart' as di;

import '../../thread/widgets/single_card_thread_widget.dart';

class OtherUserThreadWidget extends StatefulWidget {
  final UserEntity otherUser;
  const OtherUserThreadWidget({super.key, required this.otherUser});

  @override
  State<OtherUserThreadWidget> createState() => _OtherUserThreadWidgetState();
}

class _OtherUserThreadWidgetState extends State<OtherUserThreadWidget> {
  @override
  void initState() {
    BlocProvider.of<ThreadCubit>(context).readThreads(thread: const ThreadEntity());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreadCubit, ThreadState>(
        builder:(context, threadState) {
          if(threadState is ThreadLoading){
            return Center(child: circularIndicatorThreads(),);
          }
          if(threadState is ThreadFailure){
            toast('Some failure', Colors.red);
          }
          if(threadState is ThreadLoaded){
            final threads = threadState.thread.where((thread) => thread.creatorUid == widget.otherUser.uid).toList();
            return threads.isEmpty ? 
            _noThreadsYetWidget(context) : 
            ListView.builder(
              itemCount: threads.length,
              itemBuilder: (context, index){
                final thread = threads[index];
                return BlocProvider(
                  create: (context) => di.sl<ThreadCubit>(),
                  child: SingleCardThreadWidget(thread: thread),
                );
              }
            );
          }
          return Center(child: circularIndicatorThreads(),);
        },
    );
  }

  Widget _noThreadsYetWidget(BuildContext context){
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: lightGreyColor
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 7
        ),
        child: const Text(
          'No threads yet', 
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
        ),
      )
    );
  }
}