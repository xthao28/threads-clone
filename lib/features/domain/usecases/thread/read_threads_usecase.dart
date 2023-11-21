import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class ReadThreadsUseCase{
  final FirebaseRepository firebaseRepository;
  ReadThreadsUseCase({required this.firebaseRepository});

  Stream<List<ThreadEntity>> call(ThreadEntity threadEntity){
    return firebaseRepository.readThreads(threadEntity);
  }
}