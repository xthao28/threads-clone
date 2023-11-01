import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

class AppEntity {
  final UserEntity? currentUser;
  final ThreadEntity? threadEntity;

  final String? currentUid;
  final String? threadId;

  AppEntity({this.currentUid, this.currentUser, this.threadEntity, this.threadId});
}