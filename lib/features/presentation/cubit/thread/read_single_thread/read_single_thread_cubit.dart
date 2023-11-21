import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_single_thread_usecase.dart';

part 'read_single_thread_state.dart';

class ReadSingleThreadCubit extends Cubit<ReadSingleThreadState>{
  final ReadSingleThreadUseCase readSingleThreadUseCase;

  ReadSingleThreadCubit({required this.readSingleThreadUseCase}) : super(ReadSingleThreadInitial());

  Future<void> getSingleThread(String threadId) async {
    emit(ReadSingleThreadLoading());
    try{
      final streamResponse = readSingleThreadUseCase.call(threadId);
      streamResponse.listen((thread) {
        emit(ReadSingleThreadLoaded(thread: thread.first));
      });
    } on SocketException catch(_){
      emit(ReadSingleThreadFailure());
    } catch(_){
      emit(ReadSingleThreadFailure());
    }
  }
}