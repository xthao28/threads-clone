import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:threads_clone/features/data/data_source/remote_data_source.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource{

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage; 

  FirebaseRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.firebaseAuth,
    required this.firebaseStorage
  });

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  // ignore: unnecessary_null_comparison
  Future<bool> isSignIn() async => firebaseAuth.currentUser!.uid != null;

  @override
  Future<void> signInUser(UserEntity user) {
    // TODO: implement signInUser
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUpUser(UserEntity user) {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }

}