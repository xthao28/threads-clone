import '../../entities/user/user_entity.dart';
import '../../repository/firebase_repository.dart';

class SignUpUserUseCase{
  final FirebaseRepository firebaseRepository;
  SignUpUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity user){
    return firebaseRepository.signUpUser(user);
  }
}