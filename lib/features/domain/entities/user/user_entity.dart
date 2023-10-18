import 'dart:io';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? uid;
  final String? username;
  final String? name;
  final String? email;
  final String? bio;
  final String? link;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalThreads;

  final String? password;
  final File? imageFile;
  final String? otherUid;

  const UserEntity({
    this.uid, 
    this.username, 
    this.name,
    this.email, 
    this.bio, 
    this.link, 
    this.profileUrl, 
    this.followers, 
    this.following, 
    this.totalFollowers, 
    this.totalFollowing, 
    this.totalThreads, 
    this.password, 
    this.imageFile, 
    this.otherUid
  });

  @override
  List<Object?> get props => [
    uid,
    username,
    name,
    email,
    bio,
    link,
    profileUrl,
    followers,
    following,
    totalFollowers,
    totalFollowing,
    totalThreads,
    password,
    imageFile,
    otherUid
  ];
}