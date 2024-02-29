import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';

import '../../../domain/usecases/reply/create_reply_usecase.dart';
import '../../../domain/usecases/reply/delete_reply_usecase.dart';
import '../../../domain/usecases/reply/like_reply_usecase.dart';
import '../../../domain/usecases/reply/read_replies_usecase.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState>{
  final CreateReplyUseCase createReplyUseCase;
  final DeleteReplyUseCase deleteReplyUseCase;
  final LikeReplyUseCase likeReplyUseCase;
  final ReadRepliesUseCase readRepliesUseCase;

  ReplyCubit({
    required this.createReplyUseCase,
    required this.deleteReplyUseCase,
    required this.likeReplyUseCase,
    required this.readRepliesUseCase
  }) : super(ReplyInitial());

  Future<void> readReplys({required ReplyEntity reply}) async {
    emit(ReplyLoading());
    try{
      final streamResponse = readRepliesUseCase.call(reply);
      streamResponse.listen((replies) {
        emit(ReplyLoaded(reply: replies));
      });
    } on SocketException catch(_){
      emit(ReplyFailure());
    } catch(_){
      emit(ReplyFailure());
    }
  }

  Future<void> createReply({required ReplyEntity reply}) async{
    try{
      await createReplyUseCase.call(reply);
    } on SocketException catch(_){
      emit(ReplyFailure());
    } catch(_){
      emit(ReplyFailure());
    }
  }

  Future<void> deleteReply({required ReplyEntity reply}) async{
    try{
      await deleteReplyUseCase.call(reply);
    } on SocketException catch(_){
      emit(ReplyFailure());
    } catch(_){
      emit(ReplyFailure());
    }
  }

  Future<void> likeReply({required ReplyEntity reply}) async{
    try{
      await likeReplyUseCase.call(reply);
    } on SocketException catch(_){
      emit(ReplyFailure());
    } catch(_){
      emit(ReplyFailure());
    }
  }
}