part of 'thread_cubit.dart';

abstract class ThreadState extends Equatable{
  const ThreadState();
}

class ThreadInitial extends ThreadState{
  @override
  List<Object> get props => [];
}

class ThreadLoading extends ThreadState{
  @override
  List<Object> get props => [];
}

class ThreadLoaded extends ThreadState{
  final List<ThreadEntity> thread;
  const ThreadLoaded({required this.thread});

  @override
  List<Object> get props => [thread];
}

class ThreadFailure extends ThreadState{
  @override
  List<Object> get props => [];
}