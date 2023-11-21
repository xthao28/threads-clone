import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class FollowUnFollowUserUseCase{
  final FirebaseRepository firebaseRepository;
  const FollowUnFollowUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity user) async{
    return firebaseRepository.followUnFollowUser(user);
  }
}