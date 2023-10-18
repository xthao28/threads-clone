import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/profile_main_widget.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return ProfileMainWidget(currentUser: currentUser,);
  }
}