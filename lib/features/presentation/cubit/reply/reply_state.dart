part of 'reply_cubit.dart';

abstract class ReplyState extends Equatable{
  const ReplyState();
}

class ReplyInitial extends ReplyState{
  @override
  List<Object> get props => [];
}

class ReplyLoading extends ReplyState{
  @override
  List<Object> get props => [];
}

class ReplyLoaded extends ReplyState{
  final List<ReplyEntity> reply;
  const ReplyLoaded({required this.reply});

  @override
  List<Object> get props => [reply];
}

class ReplyFailure extends ReplyState{
  @override
  List<Object> get props => [];
}