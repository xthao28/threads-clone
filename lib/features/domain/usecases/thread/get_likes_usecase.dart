import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class GetLikesUseCase{
  final FirebaseRepository firebaseRepository;

  GetLikesUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(List<dynamic> listLikes){
    return firebaseRepository.getLikes(listLikes);
  }
}