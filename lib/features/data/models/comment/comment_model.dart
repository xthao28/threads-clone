// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threads_clone/features/domain/entities/comment/comment_entity.dart';

class CommentModel extends CommentEntity{
  final String? commentId;
  final String? threadId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;
  
  const CommentModel({
    required this.commentId,
    required this.threadId,
    required this.creatorUid,
    required this.description,
    required this.username,
    required this.userProfileUrl,
    required this.createdAt,
    required this.likes,
    required this.totalReplies
  }) : super(
    commentId: commentId, 
    threadId: threadId, 
    creatorUid: creatorUid, 
    description: description, 
    username: username, 
    userProfileUrl: userProfileUrl, 
    createdAt: createdAt, 
    likes: likes, 
    totalReplies: totalReplies
  );

  factory CommentModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      commentId: snapshot['commentId'], 
      threadId: snapshot['threadId'], 
      creatorUid: snapshot['creatorUid'], 
      description: snapshot['description'], 
      username: snapshot['username'], 
      userProfileUrl: snapshot['userProfileUrl'], 
      createdAt: snapshot['createdAt'], 
      likes: List.from(snap.get('likes')), 
      totalReplies: snapshot['totalReplies']
    );
  }

  Map<String, dynamic> toJson() => {
    'commentId': commentId,
    'threadId': threadId,
    'creatorUid': creatorUid,
    'description': description,
    'username': username,
    'userProfileUrl': userProfileUrl,
    'createdAt': createdAt,
    'likes': likes,
    'totalReplies': totalReplies,    
  };

}