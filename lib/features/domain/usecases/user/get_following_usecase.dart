import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

import '../../entities/user/user_entity.dart';

class GetFollowingUseCase{
  final FirebaseRepository firebaseRepository;
  GetFollowingUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(List<dynamic> listFollowing){
    return firebaseRepository.getFollowing(listFollowing);
  }
}