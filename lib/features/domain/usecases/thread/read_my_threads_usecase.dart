import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class ReadMyThreadsUseCase{
  final FirebaseRepository firebaseRepository;
  ReadMyThreadsUseCase({required this.firebaseRepository});

  Stream<List<ThreadEntity>> call(String currentUid){
    return firebaseRepository.readMyThreads(currentUid);
  }
}