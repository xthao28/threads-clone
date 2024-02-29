import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class GetSingleOtherUserUseCase{
  final FirebaseRepository firebaseRepository;

  GetSingleOtherUserUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call(String otherUid){
    return firebaseRepository.getSingleOtherUser(otherUid);
  }
}