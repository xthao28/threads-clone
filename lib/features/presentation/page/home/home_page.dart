import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/page/thread/widgets/single_card_thread_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;
import '../../../../utils/colors.dart';
import '../../../../utils/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shadowColor: backgroundColor,
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
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
    return Center(
      child: text(
        'No Threads Yet', 
        18.0, 
        FontWeight.bold, 
        black
      )      
    );
  }
}