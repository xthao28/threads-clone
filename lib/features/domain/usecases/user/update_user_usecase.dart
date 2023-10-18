import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class UpdateUserUseCase{
  final FirebaseRepository firebaseRepository;
  UpdateUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async {
    return firebaseRepository.updateUser(user);
  }
}