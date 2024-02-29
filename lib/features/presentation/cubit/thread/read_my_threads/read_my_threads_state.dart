part of 'read_my_threads_cubit.dart';

abstract class ReadMyThreadsState extends Equatable{
  const ReadMyThreadsState();
}

class ReadMyThreadsInitial extends ReadMyThreadsState{
  @override
  List<Object> get props => [];
}

class ReadMyThreadsLoading extends ReadMyThreadsState{
  @override
  List<Object> get props => [];
}

class ReadMyThreadsLoaded extends ReadMyThreadsState{
  final List<ThreadEntity> thread;
  const ReadMyThreadsLoaded({required this.thread});
  @override
  List<Object> get props => [thread];
}

class ReadMyThreadsFailure extends ReadMyThreadsState{
  @override
  List<Object> get props => [];
}