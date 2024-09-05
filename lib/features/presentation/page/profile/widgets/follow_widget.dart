import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/activity/widgets/following_tab_widget.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';
import '../../activity/widgets/followers_tab_widget.dart';

class FollowWidget extends StatefulWidget {
  final UserEntity currentUser;
  const FollowWidget({super.key, required this.currentUser});

  @override
  State<FollowWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 2, vsync: this);
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.only(
          top: 7,                      
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5/2),
                color: grey
              ),
            ),
            sizeVer(10),
            Expanded(
              child: Column(
                children: [
                  Container(                    
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: lightGreyColor,
                          width: 1
                        )
                      )
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: TabBar(
                      controller: tabController,
                      indicatorWeight: 1,                    
                      indicatorColor: Colors.black,
                      unselectedLabelColor: Colors.grey,    
                      splashFactory: NoSplash.splashFactory,                  
                      tabs: [
                        Tab(child: labelTab('Followers')),
                        Tab(child: labelTab('Following'),),                        
                      ]
                    ),
                  ),                
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        FollowersTabWidget(currentUser: widget.currentUser),
                        FollowingTabWidget(currentUser: widget.currentUser)
                      ]
                    ),
                  ),                
                ],
              ),
            )          
          ],
        ),
      ),
    );
  }
}