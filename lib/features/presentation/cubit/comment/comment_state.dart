part of 'comment_cubit.dart';

abstract class CommentState extends Equatable{
  const CommentState();
}

class CommentInitial extends CommentState{
  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState{
  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState{
  final List<CommentEntity> comment;
  const CommentLoaded({required this.comment});
  @override
  List<Object> get props => [comment];
}

class CommentFailure extends CommentState{
  @override
  List<Object> get props => [];
}