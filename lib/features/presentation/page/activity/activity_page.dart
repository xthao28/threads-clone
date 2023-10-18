import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

class ActivityPage extends StatelessWidget {
  final UserEntity currentUser;
  const ActivityPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Activity Page'),);
  }
}