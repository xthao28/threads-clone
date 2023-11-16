part of 'get_followers_cubit.dart';

abstract class GetFollowersState extends Equatable{
  const GetFollowersState();
}

class GetFollowersInitial extends GetFollowersState{
  @override
  List<Object> get props => [];
}

class GetFollowersLoading extends GetFollowersState{
  @override
  List<Object> get props => [];
}

class GetFollowersLoaded extends GetFollowersState{
  final List<UserEntity> users;
  const GetFollowersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class GetFollowersFailure extends GetFollowersState{
  @override
  List<Object> get props => [];
}