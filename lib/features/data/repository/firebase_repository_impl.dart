import 'dart:io';

import 'package:threads_clone/features/data/data_source/remote_data_source.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});


  //User

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async => remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async => remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async => remoteDataSource.updateUser(user);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async => remoteDataSource.uploadImageToStorage(file, isPost, childName);

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) => remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) => remoteDataSource.getUsers(user);

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) => remoteDataSource.getSingleOtherUser(otherUid);


//Thread

  @override
  Future<void> createThread(ThreadEntity threadEntity) => remoteDataSource.createThread(threadEntity);

  @override
  Future<void> deleteThread(ThreadEntity threadEntity) => remoteDataSource.deleteThread(threadEntity);

  @override
  Future<void> likeThread(ThreadEntity threadEntity) => remoteDataSource.likeThread(threadEntity);

  @override
  Future<void> updateThread(ThreadEntity threadEntity) => remoteDataSource.updateThread(threadEntity);

  @override
  Stream<List<ThreadEntity>> readThreads(ThreadEntity threadEntity) => remoteDataSource.readThreads(threadEntity);

  @override
  Stream<List<ThreadEntity>> readSingleThread(String threadId) => remoteDataSource.readSingleThread(threadId);
}