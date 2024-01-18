import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable{
  final String? commentId;
  final String? threadId;
  final String? creatorUid;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createdAt;
  final List<String>? likes;
  final num? totalReplies;
  
  const CommentEntity({
    required this.commentId,
    required this.threadId,
    required this.creatorUid,
    required this.description,
    required this.username,
    required this.userProfileUrl,
    required this.createdAt,
    required this.likes,
    required this.totalReplies
  });

  @override
  List<Object?> get props => [
    commentId,
    threadId,
    creatorUid,
    description,
    username,
    userProfileUrl,
    createdAt,
    likes,
    totalReplies
  ];

  

}