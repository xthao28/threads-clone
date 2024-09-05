import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/thread/get_likes_usecase.dart';

part 'get_likes_state.dart';

class GetLikesCubit extends Cubit<GetLikesState>{
  final GetLikesUseCase getLikesUseCase;
  GetLikesCubit({required this.getLikesUseCase}) : super(GetLikesInitial());
  
  Future<void> getLikes({required List<dynamic> listLikes}) async{
    emit(GetLikesLoading());
    try{
      final streamResponse = getLikesUseCase.call(listLikes);
      streamResponse.listen((listUsers) { 
        emit(GetLikesLoaded(listUsers: listUsers));
      });
    } on SocketException catch(_){
      emit(GetLikesFailure());
    } catch(_){
      emit(GetLikesFailure());
    }
  } 
}