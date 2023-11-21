
import '../../entities/user/user_entity.dart';
import '../../repository/firebase_repository.dart';

class SignInUserUseCase{
  final FirebaseRepository firebaseRepository;
  SignInUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity user){
    return firebaseRepository.signInUser(user);
  }
}