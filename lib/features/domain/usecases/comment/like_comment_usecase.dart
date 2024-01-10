import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class LikeCommentUseCase{
  final FirebaseRepository firebaseRepository;
  LikeCommentUseCase({required this.firebaseRepository});

  Future<void> call(CommentEntity commentEntity){
    return firebaseRepository.likeComment(commentEntity);
  }
}