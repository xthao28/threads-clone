import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/usecases/thread/create_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/delete_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/like_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_threads_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/update_thread_usecase.dart';

part 'thread_state.dart';

class ThreadCubit extends Cubit<ThreadState>{
  final CreateThreadUseCase createThreadUseCase;
  final DeleteThreadUseCase deleteThreadUseCase;
  final LikeThreadUseCase likeThreadUseCase;
  final ReadThreadsUseCase readThreadsUseCase;
  final UpdateThreadUseCase updateThreadUseCase;

  ThreadCubit({
    required this.createThreadUseCase,
    required this.deleteThreadUseCase,
    required this.likeThreadUseCase,
    required this.readThreadsUseCase,
    required this.updateThreadUseCase,
  }) : super(ThreadInitial());

  Future<void> readThreads({required ThreadEntity thread}) async{
    emit(ThreadLoading());
    try{
      final streamResponse = readThreadsUseCase.call(thread);
      streamResponse.listen((threads) {
        emit(ThreadLoaded(thread: threads));
      });
    } on SocketException catch(_){
      emit(ThreadFailure());
    } catch(_){
      emit(ThreadFailure());
    }
  }

  Future<void> createThread({required ThreadEntity thread}) async{
    try{
      await createThreadUseCase.call(thread);
    } on SocketException catch(_){
      emit(ThreadFailure());
    } catch(_){
      emit(ThreadFailure());
    }
  }

  Future<void> likeThread({required ThreadEntity thread}) async{
    try{
      await createThreadUseCase.call(thread);
    } on SocketException catch(_){
      emit(ThreadFailure());
    } catch(_){
      emit(ThreadFailure());
    }
  }

  Future<void> updateThread({required ThreadEntity thread}) async{
    try{
      await createThreadUseCase.call(thread);
    } on SocketException catch(_){
      emit(ThreadFailure());
    } catch(_){
      emit(ThreadFailure());
    }
  }

  Future<void> deleteThread({required ThreadEntity thread}) async{
    try{
      await createThreadUseCase.call(thread);
    } on SocketException catch(_){
      emit(ThreadFailure());
    } catch(_){
      emit(ThreadFailure());
    }
  }
}