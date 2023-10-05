
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/is_sign_in_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/sign_out_usecase.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUserCase getCurrentUidUserCase;

  AuthCubit({
    required this.signOutUseCase,
    required this.isSignInUseCase,
    required this.getCurrentUidUserCase
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext buildContext) async{
    try{
      bool isSignIn = await isSignInUseCase.call();
      if(isSignIn == true){
        final uid = await getCurrentUidUserCase.call();
        emit(Authenticated(uid: uid));
      }
      else{
        emit(UnAuthenticated());
      }
    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try{
      final uid = await getCurrentUidUserCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
}