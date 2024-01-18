// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threads_clone/features/domain/entities/reply/reply_entity.dart';

class ReplyModel extends ReplyEntity{
  final String? commentId;
  final String? threadId;
  final String? creatorUid;
  final String? replyId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;  
  
  const ReplyModel({
    required this.commentId,
    required this.threadId,
    required this.creatorUid,
    required this.replyId,
    required this.description,
    required this.username,
    required this.userProfileUrl,
    required this.createdAt,
    required this.likes,    
  }) : super(
    commentId: commentId, 
    threadId: threadId, 
    creatorUid: creatorUid, 
    replyId: replyId,
    description: description, 
    username: username, 
    userProfileUrl: userProfileUrl, 
    createdAt: createdAt, 
    likes: likes,     
  );

  factory ReplyModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReplyModel(
      commentId: snapshot['commentId'], 
      threadId: snapshot['threadId'], 
      creatorUid: snapshot['creatorUid'], 
      replyId: snapshot['replyId'],
      description: snapshot['description'], 
      username: snapshot['username'], 
      userProfileUrl: snapshot['userProfileUrl'], 
      createdAt: snapshot['createdAt'], 
      likes: List.from(snap.get('likes')),       
    );
  }

  Map<String, dynamic> toJson() => {
    'commentId': commentId,
    'threadId': threadId,
    'creatorUid': creatorUid,
    'replyId': replyId,
    'description': description,
    'username': username,
    'userProfileUrl': userProfileUrl,
    'createdAt': createdAt,
    'likes': likes,        
  };

}