import '../../repository/firebase_repository.dart';

class GetCurrentUidUserCase{
  final FirebaseRepository firebaseRepository;

  GetCurrentUidUserCase({required this.firebaseRepository});

  Future<String> call(){
    return firebaseRepository.getCurrentUid();
  }
}