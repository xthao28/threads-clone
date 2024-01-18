import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class DeleteReplyUseCase{
  final FirebaseRepository firebaseRepository;
  DeleteReplyUseCase({required this.firebaseRepository});

  Future<void> call(ReplyEntity replyEntity){
    return firebaseRepository.deleteReply(replyEntity);    
  }
}