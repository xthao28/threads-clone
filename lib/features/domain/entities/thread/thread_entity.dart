

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ThreadEntity extends Equatable{
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

  const ThreadEntity({
    this.creatorUid, 
    this.threadId, 
    this.threadImageUrl, 
    this.totalLikes, 
    this.totalComments, 
    this.userProfileUrl, 
    this.likes, 
    this.description, 
    this.username, 
    this.createdAt
  });
  
  @override  
  List<Object?> get props => [
    creatorUid,
    threadId,
    threadImageUrl,
    totalComments,
    totalLikes,
    userProfileUrl,
    likes,
    description,
    username,
    createdAt
  ];

}