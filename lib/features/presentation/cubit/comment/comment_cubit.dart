import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/usecases/comment/create_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/like_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/read_comments_usecase.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState>{
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentsUseCase readCommentsUseCase;

  CommentCubit({
    required this.createCommentUseCase,
    required this.deleteCommentUseCase,
    required this.likeCommentUseCase,
    required this.readCommentsUseCase
  }) : super(CommentInitial());

  Future<void> readComments({required String threadId}) async {
    emit(CommentLoading());
    try{
      final streamResponse = readCommentsUseCase.call(threadId);
      streamResponse.listen((comments) {
        emit(CommentLoaded(comment: comments));
      });
    } on SocketException catch(_){
      emit(CommentFailure());
    } catch(_){
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity comment}) async{
    try{
      await createCommentUseCase.call(comment);
    } on SocketException catch(_){
      emit(CommentFailure());
    } catch(_){
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity comment}) async{
    try{
      await deleteCommentUseCase.call(comment);
    } on SocketException catch(_){
      emit(CommentFailure());
    } catch(_){
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity comment}) async{
    try{
      await likeCommentUseCase.call(comment);
    } on SocketException catch(_){
      emit(CommentFailure());
    } catch(_){
      emit(CommentFailure());
    }
  }
}