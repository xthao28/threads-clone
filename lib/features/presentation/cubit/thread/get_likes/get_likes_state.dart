part of 'get_likes_cubit.dart';

abstract class GetLikesState extends Equatable{
  const GetLikesState();
}

class GetLikesInitial extends GetLikesState{
  @override  
  List<Object> get props => [];  
}

class GetLikesLoading extends GetLikesState{
  @override  
  List<Object> get props => [];
}

class GetLikesLoaded extends GetLikesState{
  final List<UserEntity> listUsers;
  const GetLikesLoaded({required this.listUsers});
  
  @override  
  List<Object> get props => [listUsers];  
}

class GetLikesFailure extends GetLikesState{
  @override
  List<Object> get props => [];
}
