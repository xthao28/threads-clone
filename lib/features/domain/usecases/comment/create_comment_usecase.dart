import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class CreateCommentUseCase{
  final FirebaseRepository firebaseRepository;
  CreateCommentUseCase({required this.firebaseRepository});

  Future<void> call(CommentEntity commentEntity) {
    return firebaseRepository.createComment(commentEntity);
  }
}