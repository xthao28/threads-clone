import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/setting/widget/setting_main_widget.dart';

class SettingPage extends StatelessWidget {
  final UserEntity currentUser;
  const SettingPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return SettingMainWidget(currentUser: currentUser);
  }
}