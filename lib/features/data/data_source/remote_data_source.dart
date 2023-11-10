
import 'dart:io';

import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';

import '../../domain/entities/user/user_entity.dart';

abstract class FirebaseRemoteDataSource{
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();

  Future<String> getCurrentUid();  
  Future<void> updateUser(UserEntity user);
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);
  Stream<List<UserEntity>> getSingleUser(String uid);
  Stream<List<UserEntity>> getUsers(UserEntity user);
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid);
  Future<void> followUnFollowUser(UserEntity user);

  //Thread

  Future<void> createThread(ThreadEntity threadEntity);
  Future<void> deleteThread(ThreadEntity threadEntity);
  Future<void> likeThread(ThreadEntity threadEntity);
  Future<void> updateThread(ThreadEntity threadEntity);
  Stream<List<ThreadEntity>> readThreads(ThreadEntity threadEntity);
  Stream<List<ThreadEntity>> readSingleThread(String threadId);
  Stream<List<ThreadEntity>> readMyThreads(String currentUid);

}