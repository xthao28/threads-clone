part of 'read_single_thread_cubit.dart';

abstract class ReadSingleThreadState extends Equatable{
  const ReadSingleThreadState();
}

class ReadSingleThreadInitial extends ReadSingleThreadState{
  @override
  List<Object> get props => [];
}

class ReadSingleThreadLoading extends ReadSingleThreadState{
  @override
  List<Object> get props => [];
}

class ReadSingleThreadLoaded extends ReadSingleThreadState{
  final ThreadEntity thread;
  const ReadSingleThreadLoaded({required this.thread});

  @override
  List<Object> get props => [thread];
}

class ReadSingleThreadFailure extends ReadSingleThreadState{
  @override
  List<Object> get props => [];
}