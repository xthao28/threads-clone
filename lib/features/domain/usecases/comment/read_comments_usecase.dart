import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class ReadCommentsUseCase{
  final FirebaseRepository firebaseRepository;
  ReadCommentsUseCase({required this.firebaseRepository});

  Stream<List<CommentEntity>> call(String threadId){
    return firebaseRepository.readComments(threadId);
  }
}