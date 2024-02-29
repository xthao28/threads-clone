import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class GetUsersUseCase{
  final FirebaseRepository firebaseRepository;

  GetUsersUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(UserEntity user){
    return firebaseRepository.getUsers(user);
  }
}