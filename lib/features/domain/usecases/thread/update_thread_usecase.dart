import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class UpdateThreadUseCase{
  final FirebaseRepository firebaseRepository;
  UpdateThreadUseCase({required this.firebaseRepository});

  Future<void> call(ThreadEntity threadEntity){
    return firebaseRepository.updateThread(threadEntity);
  }
}