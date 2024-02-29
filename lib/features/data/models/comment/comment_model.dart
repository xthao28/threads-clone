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
  final num? totalLikes;
  
  const CommentModel({
    this.commentId,
    this.threadId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createdAt,
    this.likes,
    this.totalReplies,
    this.totalLikes
  }) : super(
    commentId: commentId, 
    threadId: threadId, 
    creatorUid: creatorUid, 
    description: description, 
    username: username, 
    userProfileUrl: userProfileUrl, 
    createdAt: createdAt, 
    likes: likes, 
    totalReplies: totalReplies,
    totalLikes: totalLikes
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
      totalReplies: snapshot['totalReplies'],
      totalLikes: snapshot['totalLikes']
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
    'totalLikes': totalLikes 
  };

}