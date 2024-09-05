
import 'dart:io';

import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';

import '../../domain/entities/comment/comment_entity.dart';
import '../../domain/entities/reply/reply_entity.dart';
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
  Stream<List<UserEntity>> getFollowers(List<dynamic> listFollowers);
  Stream<List<UserEntity>> getFollowing(List<dynamic> listFollowing);
  Future<void> followUnFollowUser(UserEntity user);

  //Thread

  Future<void> createThread(ThreadEntity threadEntity);
  Future<void> deleteThread(ThreadEntity threadEntity);
  Future<void> likeThread(ThreadEntity threadEntity);
  Future<void> updateThread(ThreadEntity threadEntity);
  Stream<List<ThreadEntity>> readThreads(ThreadEntity threadEntity);
  Stream<List<ThreadEntity>> readSingleThread(String threadId);
  Stream<List<ThreadEntity>> readMyThreads(String currentUid);
  Stream<List<UserEntity>> getLikes(List<dynamic> listLikes);

  //Comment
  Future<void> createComment(CommentEntity commentEntity);
  Future<void> deleteComment(CommentEntity commentEntity);
  Future<void> likeComment(CommentEntity commentEntity);
  Stream<List<CommentEntity>> readComments(String threadId);
  // Stream<List<CommentEntity>> readSingleComment(String threadId, String commentId);

  //Reply
  Future<void> createReply(ReplyEntity replyEntity);
  Future<void> deleteReply(ReplyEntity replyEntity);
  Future<void> likeReply(ReplyEntity replyEntity);
  Stream<List<ReplyEntity>> readReplys(ReplyEntity replyEntity);

}