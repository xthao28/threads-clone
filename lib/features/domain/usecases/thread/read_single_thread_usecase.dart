import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class ReadSingleThreadUseCase{
  final FirebaseRepository firebaseRepository;
  ReadSingleThreadUseCase({required this.firebaseRepository});

  Stream<List<ThreadEntity>> call(String threadId){
    return firebaseRepository.readSingleThread(threadId);
  }
}