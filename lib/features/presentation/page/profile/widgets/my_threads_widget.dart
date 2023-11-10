import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_my_threads/read_my_threads_cubit.dart';
import 'package:threads_clone/features/presentation/page/home/widget/single_card_thread_widget.dart';

import '../../../../../consts.dart';
import '../../../widgets/create_thread_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;

class MyThreadsWidget extends StatelessWidget {
  final UserEntity currentUser;
  const MyThreadsWidget({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadMyThreadsCubit, ReadMyThreadsState>(
        builder:(context, threadState) {
          if(threadState is ReadMyThreadsLoading){
            return Center(child: circularIndicatorThreads(),);
          }
          if(threadState is ReadMyThreadsFailure){
            toast('Some failure', Colors.red);
          }
          if(threadState is ReadMyThreadsLoaded){
            return threadState.thread.isEmpty ? 
            _noThreadsYetWidget(context) : 
            ListView.builder(
              itemCount: threadState.thread.length,
              itemBuilder: (context, index){
                final thread = threadState.thread[index];
                return BlocProvider(
                  create: (context) => di.sl<ReadMyThreadsCubit>(),
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
      child: InkWell(
        onTap: (){
          showModalBottomSheet(  
            isScrollControlled: true,                        
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            context: context, 
            builder: (BuildContext context){
              return CreateThreadWidget(currentUser: currentUser,);
            }
          );
        },
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
            'Start your first thread', 
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
        ),
      )
    );
  }
}