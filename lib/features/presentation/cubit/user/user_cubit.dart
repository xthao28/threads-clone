import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/user/get_users_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState>{
  final GetUsersUseCase getUsersUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserCubit({
    required this.getUsersUseCase,
    required this.updateUserUseCase
  }) : super(UserInitial());

  Future<void> getUsers({required UserEntity user}) async{
    emit(UserLoading());
    try{
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(user: users));
      });
    } on SocketException catch(_){
      emit(UserFailure());
    } catch(_){
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async{
    try{
      await updateUserUseCase.call(user);
    } on SocketException catch(_){
      emit(UserFailure());
    } catch(_){
      emit(UserFailure());
    }
  }
}
