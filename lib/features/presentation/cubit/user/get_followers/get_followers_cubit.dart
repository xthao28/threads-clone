import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:threads_clone/features/domain/usecases/user/get_followers_usecase.dart';

import '../../../../domain/entities/user/user_entity.dart';

part 'get_followers_state.dart';

class GetFollowersCubit extends Cubit<GetFollowersState>{
  final GetFollowersUseCase getFollowersUseCase;
  GetFollowersCubit({required this.getFollowersUseCase}) : super(GetFollowersInitial());

  Future<void> getFollowers({required List<dynamic> listFollowers}) async{
    emit(GetFollowersLoading());
    try{
      final streamResponse = getFollowersUseCase.call(listFollowers);
      streamResponse.listen((users) { 
        emit(GetFollowersLoaded(users: users));
      });      
    } on SocketException catch(_){
      emit(GetFollowersFailure());      
    } catch(_){
      emit(GetFollowersFailure());
    }
  }
}