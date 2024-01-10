import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class ReadRepliesUseCase{
  final FirebaseRepository firebaseRepository;
  ReadRepliesUseCase({required this.firebaseRepository});

  Stream<List<ReplyEntity>> call(ReplyEntity replyEntity){
    return firebaseRepository.readReplys(replyEntity);
  }
}