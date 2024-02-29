import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class GetFollowersUseCase{
  final FirebaseRepository firebaseRepository;
  GetFollowersUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(List<dynamic> listFollowers){
    return firebaseRepository.getFollowers(listFollowers);
  }
}