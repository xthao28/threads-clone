// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';

class ThreadModel extends ThreadEntity{
  final String? creatorUid;
  final String? threadId;
  final String? threadImageUrl;
  final num? totalLikes;
  final num? totalComments;
  final String? userProfileUrl;
  final List<String>? likes;
  final String? description;
  final String? username;
  final Timestamp? createdAt;

  const ThreadModel({
    this.createdAt,
    this.creatorUid,
    this.description,
    this.likes,
    this.threadId,
    this.threadImageUrl,
    this.totalComments,
    this.totalLikes,
    this.userProfileUrl,
    this.username
  }) : super(
    createdAt: createdAt,
    creatorUid: creatorUid,
    description: description,
    likes: likes,
    threadId: threadId,
    threadImageUrl: threadImageUrl,
    totalComments: totalComments,
    totalLikes: totalLikes,
    userProfileUrl: userProfileUrl,
    username: username
  );

  factory ThreadModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    
    return ThreadModel(
      createdAt: snapshot['createdAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      likes: List.from(snap.get('likes')),
      threadId: snapshot['threadId'],
      threadImageUrl: snapshot['threadImageUrl'],
      totalComments: snapshot['totalComments'],
      totalLikes: snapshot['totalLikes'],
      userProfileUrl: snapshot['userProfileUrl'],
      username: snapshot['username'],
    );
  }

  Map<String, dynamic> toJson() => {
    'createAt': createdAt,
    'creatorUid': creatorUid,
    'description': description,
    'likes': likes,
    'threadId': threadId,
    'threadImageUrl': threadImageUrl,
    'totalComments': totalComments,
    'totalLikes': totalLikes,
    'userProfileUrl': userProfileUrl,
    'username': username
  };

}