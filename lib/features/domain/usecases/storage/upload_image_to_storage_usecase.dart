
import 'dart:io';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class UploadImageToStorageUseCase{
  final FirebaseRepository firebaseRepository;

  UploadImageToStorageUseCase({ required this.firebaseRepository});

  Future<String> call(File file, bool isPost, String childName){
    return firebaseRepository.uploadImageToStorage(file, isPost, childName);
  }
}