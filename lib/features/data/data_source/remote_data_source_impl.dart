import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/utils/consts.dart';
import 'package:threads_clone/features/data/data_source/remote_data_source.dart';
import 'package:threads_clone/features/data/models/comment/comment_model.dart';
import 'package:threads_clone/features/data/models/reply/reply_model.dart';
import 'package:threads_clone/features/data/models/thread/thread_model.dart';
import 'package:threads_clone/features/data/models/user/user_model.dart';
import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/widgets.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource{

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage; 

  FirebaseRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage
  });


  //User

  Future<void> createUserWithImage(UserEntity user, String profileUrl) async{
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    
    final uid = await getCurrentUid();    

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        name: user.name,
        bio: user.bio,
        link: user.link,
        followers: user.followers,
        following: user.following,
        totalFollowers: user.totalFollowers,
        totalFollowing: user.totalFollowing,
        totalThreads: user.totalThreads,
        profileUrl: profileUrl
      ).toJson();

      if(!userDoc.exists){
        userCollection.doc(uid).set(newUser);
      }else{
        userCollection.doc(uid).update(newUser);
      }      
    }).catchError((error){      
      toast('Some error occur', Colors.red);
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  // ignore: unnecessary_null_comparison
  Future<bool> isSignIn() async => firebaseAuth.currentUser!.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async{
    try{
      if(user.email!.isNotEmpty || user.password!.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
        // toast('Sign In Success', Colors.green);
      }else{
        toast('Fields cannot be empty', Colors.red);
      }
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        toast('User not found', Colors.red);
      }else if(e.code == 'wrong-password'){
        toast('Invalid email or password', Colors.red);
      }else{
        toast('Something went wrong', Colors.red);
      }
    }
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async{
    try{                       
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!).then((currentUser) async{
        if(currentUser.user?.uid != null){
          if(user.imageFile != null){
            await uploadImageToStorage(user.imageFile, false, 'profileImages').then((profileUrl) {
              createUserWithImage(user, profileUrl);              
            });
          }
          else{
            createUserWithImage(user, '');
          }
        }
        toast('Sign Up Success', Colors.green);
      }); 
      return;      
    }on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use') {
        toast('Email is already in use', Colors.red);
      }else{
        toast('Something went wrong', Colors.red);
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async{
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    // ignore: prefer_collection_literals
    Map<String, dynamic> userInfo = Map();

    if(user.bio != '' || user.bio != null) userInfo['bio'] = user.bio;
    if(user.name != '' || user.name != null) userInfo['name'] = user.name;
    if(user.link != '' || user.link != null) userInfo['link'] = user.link;
    if(user.profileUrl != '' || user.profileUrl != null) userInfo['profileUrl'] = user.profileUrl;    

    userCollection.doc(user.uid).update(userInfo);
  }

  @override
  Future<String> uploadImageToStorage(File? file, bool isThread, String childName) async{
    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if(isThread){
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Future<void> followUnFollowUser(UserEntity user) async{
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final myDocRef = await userCollection.doc(user.uid).get();
    final otherUserDocRef = await userCollection.doc(user.otherUid).get();

    if(myDocRef.exists && otherUserDocRef.exists){
      List myFollowingList = myDocRef.get('following');
      List otherUserFollowersList = otherUserDocRef.get('followers');

      if(myFollowingList.contains(user.otherUid)){
        userCollection.doc(user.uid).update({'following' : FieldValue.arrayRemove([user.otherUid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);
          userCollection.get().then((value) {
            if(value.exists){
              final totalFollowing = value.get('totalFollowing');
              userCollection.update({'totalFollowing': totalFollowing - 1});
              return;
            }
          });          
        });       
      } else{
        userCollection.doc(user.uid).update({'following': FieldValue.arrayUnion([user.otherUid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);
          userCollection.get().then((value) {
            if(value.exists){
              final totalFollowing = value.get('totalFollowing');
              userCollection.update({'totalFollowing': totalFollowing + 1});
              return;
            }
          });
        });
      }
      if(otherUserFollowersList.contains(user.uid)){
        userCollection.doc(user.otherUid).update({'followers': FieldValue.arrayRemove([user.uid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.otherUid);
          userCollection.get().then((value) {
            if(value.exists){
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({'totalFollowers': totalFollowers - 1});
              return;
            }
          });
        });
      } else{
        userCollection.doc(user.otherUid).update({'followers': FieldValue.arrayUnion([user.uid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.otherUid);
          userCollection.get().then((value) {
            if(value.exists){
              final totalFollowers = value.get('totalFollowers');
              userCollection.update({'totalFollowers': totalFollowers + 1});
              return;
            }
          });
        });
      }
    }    
  }
  
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', isEqualTo: uid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }
  
  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid){
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', isEqualTo: otherUid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getFollowers(List<dynamic> listFollowers){
    if (listFollowers.isEmpty) {      
      return Stream.value([]);
    }
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', whereIn: listFollowers);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getFollowing(List<dynamic> listFollowing){
    if (listFollowing.isEmpty) {      
      return Stream.value([]);
    }
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', whereIn: listFollowing);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }


  //Thread
  
  @override
  Future<void> createThread(ThreadEntity threadEntity) async {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads);
    
    final newThread = ThreadModel(
      createdAt: threadEntity.createdAt,
      creatorUid: threadEntity.creatorUid,
      description: threadEntity.description,      
      likes: const [],
      totalComments: 0,
      totalLikes: 0,
      userProfileUrl: threadEntity.userProfileUrl,
      username: threadEntity.username,
      threadId: threadEntity.threadId,
      threadImageUrl: threadEntity.threadImageUrl,      
    ).toJson();

    try{
      final threadDocRef = await threadCollection.doc(threadEntity.threadId).get();

      if(!threadDocRef.exists){
        threadCollection.doc(threadEntity.threadId).set(newThread).then((value){
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(threadEntity.creatorUid);
          userCollection.get().then((value) {
            if(value.exists){
              final totalThreads = value.get('totalThreads');
              userCollection.update({'totalThreads': totalThreads +1});
              return;
            }
          });
        });
      }else{
        threadCollection.doc(threadEntity.threadId).update(newThread);
      }
    }catch(e){
      // ignore: avoid_print
      print('Some error occured $e');
    }
  }

  @override
  Future<void> deleteThread(ThreadEntity threadEntity) async {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads);

    try{
      threadCollection.doc(threadEntity.threadId).delete().then((value) {
        final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(threadEntity.creatorUid);
        userCollection.get().then((value) {
          if(value.exists){
            final totalThreads = value.get('totalThreads');
            userCollection.update({'totalThreads': totalThreads - 1});
            return;
          }
        });
      });
    }catch(e){
      // ignore: avoid_print
      print('Some error occured $e');
    }
  }

  @override
  Future<void> likeThread(ThreadEntity threadEntity) async {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads);
    final currentUid = await getCurrentUid();
    final threadRef = await threadCollection.doc(threadEntity.threadId).get();

    if(threadRef.exists){
      List likes = threadRef.get('likes');
      final totalLikes = threadRef.get('totalLikes');
      if(likes.contains(currentUid)){
        threadCollection.doc(threadEntity.threadId).update({
          'likes': FieldValue.arrayRemove([currentUid]),
          'totalLikes': totalLikes - 1
        });
      }else{
        threadCollection.doc(threadEntity.threadId).update({
          'likes': FieldValue.arrayUnion([currentUid]),
          'totalLikes': totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<ThreadEntity>> readSingleThread(String threadId) {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads).where('threadId', isEqualTo: threadId).limit(1);
    return threadCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ThreadModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<ThreadEntity>> readThreads(ThreadEntity threadEntity) {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads).orderBy('createdAt', descending: true);
    return threadCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ThreadModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<ThreadEntity>> readMyThreads(String currentUid) {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads).where('creatorUid', isEqualTo: currentUid);
    return threadCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ThreadModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateThread(ThreadEntity threadEntity) async {
    final threadCollection = firebaseFirestore.collection(FirebaseConst.threads);
    // ignore: prefer_collection_literals
    Map<String, dynamic> threadInfo = Map();
    if(threadEntity.description != '' || threadEntity.description != null) threadInfo['description'] = threadEntity.description!;
    if(threadEntity.threadImageUrl != '' || threadEntity.threadImageUrl != null) threadInfo['threadImageUrl'] = threadEntity.threadImageUrl!;

    threadCollection.doc(threadEntity.threadId).update(threadInfo);
  }

  @override
  Stream<List<UserEntity>> getLikes(List<dynamic> listLikes){
    if(listLikes.isEmpty){
      return Stream.value([]);
    }
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', whereIn: listLikes);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }


  //Comment

  @override
  Future<void> createComment(CommentEntity commentEntity) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(commentEntity.threadId).collection(FirebaseConst.comments);

    final newComment = CommentModel(
      commentId: commentEntity.commentId, 
      threadId: commentEntity.threadId, 
      creatorUid: commentEntity.creatorUid, 
      description: commentEntity.description, 
      username: commentEntity.username, 
      userProfileUrl: commentEntity.userProfileUrl, 
      createdAt: commentEntity.createdAt, 
      likes: const [], 
      totalReplies: commentEntity.totalReplies,
      totalLikes: commentEntity.totalLikes,
    ).toJson();

    try{
      final commentDocRef = await commentCollection.doc(commentEntity.commentId).get();
      if(!commentDocRef.exists){
        commentCollection.doc(commentEntity.commentId).set(newComment).then((value) {
          final threadCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(commentEntity.threadId);
          threadCollection.get().then((value) {
            if(value.exists){
              final totalComments = value.get('totalComments');
              threadCollection.update({'totalComments' : totalComments + 1});
              return;
            }
          });
        });
      } else{
        commentCollection.doc(commentEntity.commentId).update(newComment);
      }
    } catch(e){
      print('some error occured $e');
    }
  }

  @override
  Future<void> deleteComment(CommentEntity commentEntity) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(commentEntity.threadId).collection(FirebaseConst.comments);

    try{
      commentCollection.doc(commentEntity.commentId).delete().then((value) {
        final threadCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(commentEntity.threadId);
        threadCollection.get().then((value) {
          if(value.exists){
            final totalComments = value.get('totalComments');
            threadCollection.update({'totalComments': totalComments - 1});
            return;
          }
        });
      });
    } catch(e){
      print('some error occured $e');
    }
  } 

  @override
  Future<void> likeComment(CommentEntity commentEntity) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(commentEntity.threadId).collection(FirebaseConst.comments);
    final currentUid = await getCurrentUid();

    final commentDocRef = await commentCollection.doc(commentEntity.commentId).get();
    if(commentDocRef.exists){
      List likes = commentDocRef.get('likes');
      final totalLikes = commentDocRef.get('totalLikes');
      if(likes.contains(currentUid)){
        commentCollection.doc(commentEntity.commentId).update({
          'likes': FieldValue.arrayRemove([currentUid]),
          'totalLikes': totalLikes - 1
        });
      }else{
        commentCollection.doc(commentEntity.commentId).update({
          'likes': FieldValue.arrayUnion([currentUid]),
          'totalLikes': totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<CommentEntity>> readComments(String threadId) {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(threadId).collection(FirebaseConst.comments).orderBy('createdAt', descending: true);
    return commentCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => CommentModel.fromSnapshot(e)).toList());
  }


  //Reply

  @override
  Future<void> createReply(ReplyEntity replyEntity) async {
    final replyCollection = firebaseFirestore.collection(FirebaseConst.threads)
      .doc(replyEntity.threadId).collection(FirebaseConst.comments)
      .doc(replyEntity.commentId).collection(FirebaseConst.replies);
    final newReply = ReplyModel(
      commentId: replyEntity.commentId, 
      threadId: replyEntity.threadId, 
      creatorUid: replyEntity.creatorUid, 
      replyId: replyEntity.replyId, 
      description: replyEntity.description, 
      username: replyEntity.username, 
      userProfileUrl: replyEntity.userProfileUrl, 
      createdAt: replyEntity.createdAt, 
      likes: const []
    ).toJson();
    try{
      final replyDocRef = await replyCollection.doc(replyEntity.replyId).get();
      if(!replyDocRef.exists){
        replyCollection.doc(replyEntity.replyId).set(newReply).then((value) {
          final commentCollection = firebaseFirestore.collection(FirebaseConst.threads)
            .doc(replyEntity.threadId).collection(FirebaseConst.comments).doc(replyEntity.commentId);
          commentCollection.get().then((value) {
            if(value.exists){
              final totalReplies = value.get('totalReplies');
              commentCollection.update({'totalReplies': totalReplies + 1});
              return;
            }
          });
        });
      } else{
        replyCollection.doc(replyEntity.replyId).update(newReply);
      }
    }catch(e){
      print('some error ocurred $e');
    }
  }

  @override
  Future<void> deleteReply(ReplyEntity replyEntity) async {
    final replyCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(replyEntity.threadId)
      .collection(FirebaseConst.comments).doc(replyEntity.commentId)
      .collection(FirebaseConst.replies);
    try{
      replyCollection.doc(replyEntity.replyId).delete().then((value) {
        final commentCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(replyEntity.threadId)
          .collection(FirebaseConst.comments).doc(replyEntity.commentId);
        commentCollection.get().then((value) {
          if(value.exists){
            final totalReplies = value.get('totalReplies');
            commentCollection.update({'totalReplies': totalReplies - 1});
            return;
          }
        });
      });
    } catch(e){
      print('some error occured $e');
    }
  }

  @override
  Future<void> likeReply(ReplyEntity replyEntity) async {
    final replyCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(replyEntity.threadId)
      .collection(FirebaseConst.comments).doc(replyEntity.commentId)
      .collection(FirebaseConst.replies);
    final currentUid = await getCurrentUid();
    final replyDocRef = await replyCollection.doc(replyEntity.replyId).get();
    if(replyDocRef.exists){
      List likes = replyDocRef.get('likes');
      if(likes.contains(currentUid)){
        replyCollection.doc(replyEntity.replyId).update({
          'likes': FieldValue.arrayRemove([currentUid])
        });
      } else{
        replyCollection.doc(replyEntity.replyId).update({
          'likes': FieldValue.arrayUnion([currentUid])
        });
      }
    }
  }

  @override
  Stream<List<ReplyEntity>> readReplys(ReplyEntity replyEntity) {
    final replyCollection = firebaseFirestore.collection(FirebaseConst.threads).doc(replyEntity.threadId)
      .collection(FirebaseConst.comments).doc(replyEntity.commentId)
      .collection(FirebaseConst.replies).orderBy('createdAt', descending: true);
    return replyCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ReplyModel.fromSnapshot(e)).toList());
  }
}