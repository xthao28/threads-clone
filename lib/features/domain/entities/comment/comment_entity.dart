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
  final num? totalLikes;
  
  const CommentEntity({
    this.commentId,
    this.threadId,
    this.creatorUid,
    this.description,
    this.username,
    this.userProfileUrl,
    this.createdAt,
    this.likes,
    this.totalReplies,
    this.totalLikes,
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
    totalReplies,
    totalLikes,
  ];

  

}