import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

import '../../../../domain/usecases/user/get_single_user_usecase.dart';


part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState>{
  final GetSingleUserUseCase getSingleUserUseCase;

  GetSingleUserCubit({required this.getSingleUserUseCase}) : super(GetSingleUserInitial());

  Future<void> getSingleUser({required String uid}) async{
    emit(GetSingleUserLoading());
    try{
      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((user) {
        emit(GetSingleUserLoaded(user: user.first));
      });
    }on SocketException catch(_){
      emit(GetSingleUserFailure());
    }catch(_){
      emit(GetSingleUserFailure());
    }
  }
}