

import '../../domain/entities/user/user_entity.dart';

abstract class FirebaseRemoteDataSource{
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  Future<String> getCurrentUid();  

}