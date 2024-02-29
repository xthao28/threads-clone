import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class CreateReplyUseCase{
  final FirebaseRepository firebaseRepository;
  CreateReplyUseCase({required this.firebaseRepository});

  Future<void> call(ReplyEntity replyEntity){
    return firebaseRepository.createReply(replyEntity);
  }
}