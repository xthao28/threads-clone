import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class DeleteThreadUseCase{
  final FirebaseRepository firebaseRepository;
  DeleteThreadUseCase({required this.firebaseRepository});

  Future<void> call(ThreadEntity threadEntity){
    return firebaseRepository.deleteThread(threadEntity);
  }
}