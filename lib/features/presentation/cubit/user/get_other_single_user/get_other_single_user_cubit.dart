import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';
import 'package:threads_clone/features/domain/usecases/user/get_single_other_user_usecase.dart';

part 'get_other_single_user_state.dart';

class GetOtherSingleUserCubit extends Cubit<GetOtherSingleUserState>{
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;
  GetOtherSingleUserCubit({required this.getSingleOtherUserUseCase}) : super(GetOtherSingleUserInitial());

  Future<void> getOtherSingleUser(String otherUid)async {
    emit(GetOtherSingleUserLoading());
    try{
      final streamResponse = getSingleOtherUserUseCase.call(otherUid);
      streamResponse.listen((user) {
        emit(GetOtherSingleUserLoaded(otherUser: user.first));
      });
    }on SocketException catch(_){
      emit(GetOtherSingleUserFailure());
    }catch(_){
      emit(GetOtherSingleUserFailure());
    }
  }
}