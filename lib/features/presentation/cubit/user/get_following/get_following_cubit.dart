import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/usecases/user/get_following_usecase.dart';

import '../../../../domain/entities/user/user_entity.dart';

part 'get_following_state.dart';

class GetFollowingCubit extends Cubit<GetFollowingState>{
  final GetFollowingUseCase getFollowingUseCase;
  GetFollowingCubit({required this.getFollowingUseCase}) : super(GetFollowingInitial());

  Future<void> getFollowing({required List<dynamic> listFollowing}) async{
    emit(GetFollowingLoading());
    try{
      final streamResponse = getFollowingUseCase.call(listFollowing);
      streamResponse.listen((users) { 
        emit(GetFollowingLoaded(users: users));
      });      
    } on SocketException catch(_){
      emit(GetFollowingFailure());      
    } catch(_){
      emit(GetFollowingFailure());
    }
  }
}