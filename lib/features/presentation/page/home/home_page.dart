import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/page/home/widget/single_card_thread_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;
import '../../../../consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shadowColor: backgroundColor,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/threads.png',
          width: height*0.037,
        ),
      ),
      body: BlocBuilder<ThreadCubit, ThreadState>(
          builder: (context, threadState) {
            if(threadState is ThreadLoading){
              return Center(child: circularIndicatorThreads(),);
            }
            if(threadState is ThreadFailure){
              toast('Some failure', Colors.red);
            }
            if(threadState is ThreadLoaded){
              return threadState.thread.isEmpty ? _notThreadsYetWidget() : ListView.builder(                
                itemCount: threadState.thread.length,
                itemBuilder: (context, index){
                  final thread = threadState.thread[index];
                  return BlocProvider(
                    create: (context) => di.sl<ThreadCubit>(),
                    child: SingleCardThreadWidget(thread: thread),
                  );
                },
              );
            }
            return Center(child: circularIndicatorThreads(),);
          },
        ),      
    );
  }
  Widget _notThreadsYetWidget(){
    return const Center(
      child: Text(
        'No Threads Yet',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }
}