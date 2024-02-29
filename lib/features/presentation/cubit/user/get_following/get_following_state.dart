part of 'get_following_cubit.dart';

abstract class GetFollowingState extends Equatable{
  const GetFollowingState();
}

class GetFollowingInitial extends GetFollowingState{
  @override
  List<Object> get props => [];
}

class GetFollowingLoading extends GetFollowingState{
  @override
  List<Object> get props => [];
}

class GetFollowingLoaded extends GetFollowingState{
  final List<UserEntity> users;
  const GetFollowingLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class GetFollowingFailure extends GetFollowingState{
  @override
  List<Object> get props => [];
}