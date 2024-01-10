import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable{
  final String? commentId;
  final String? threadId;
  final String? creatorUid;
  final String? replyId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;  
  
  const ReplyEntity({
    required this.commentId,
    required this.threadId,
    required this.creatorUid,
    required this.replyId,
    required this.description,
    required this.username,
    required this.userProfileUrl,
    required this.createdAt,
    required this.likes,  
  });

  @override
  List<Object?> get props => [
    commentId,
    threadId,
    creatorUid,
    replyId,
    description,
    username,
    userProfileUrl,
    createdAt,
    likes,
  ];

  

}