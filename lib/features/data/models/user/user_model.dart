// ignore_for_file: annotate_overrides, overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity{
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

  const UserModel({
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
    this.totalThreads
  }) : super(
    uid: uid,
    username: username,
    name: name,
    email: email,
    bio: bio,
    link: link,
    profileUrl: profileUrl,
    followers: followers,
    following: following,
    totalFollowers: totalFollowers,
    totalFollowing: totalFollowing,
    totalThreads: totalThreads
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      username: snapshot['username'],
      name: snapshot['name'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      link: snapshot['link'],
      profileUrl: snapshot['profileUrl'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalThreads: snapshot['totalThreads'],
      followers: List.from(snap.get('followers')),
      following: List.from(snap.get('following'))
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'name': name,
    'email': email,
    'bio': bio,
    'link': link,
    'profileUrl': profileUrl,
    'totalFollowers': totalFollowers,
    'totalFollowing': totalFollowing,
    'totalThreads': totalThreads,
    'followers': followers,
    'following': following
  };
  
}