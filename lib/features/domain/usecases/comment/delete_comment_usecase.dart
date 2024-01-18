import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class DeleteCommentUseCase{
  final FirebaseRepository firebaseRepository;
  DeleteCommentUseCase({required this.firebaseRepository});

  Future<void> call(CommentEntity commentEntity) {
    return firebaseRepository.deleteComment(commentEntity);
  }
}