import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_my_threads_usecase.dart';

part 'read_my_threads_state.dart';

class ReadMyThreadsCubit extends Cubit<ReadMyThreadsState>{
  final ReadMyThreadsUseCase readMyThreadsUseCase;
  ReadMyThreadsCubit({required this.readMyThreadsUseCase}) : super(ReadMyThreadsInitial());

  Future<void> readMyThreads({required String currentUid}) async {
    emit(ReadMyThreadsLoading());
    try{
      final streamResponse = readMyThreadsUseCase.call(currentUid);
      streamResponse.listen((thread) {
        emit(ReadMyThreadsLoaded(thread: thread));
      });
    } on SocketException catch(_){
      emit(ReadMyThreadsFailure());
    } catch(_){
      emit(ReadMyThreadsFailure());
    }
  }
}