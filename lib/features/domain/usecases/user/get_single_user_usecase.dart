import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class GetSingleUserUseCase{
  final FirebaseRepository firebaseRepository;

  GetSingleUserUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(String uid){
    return firebaseRepository.getSingleUser(uid);
  }
}