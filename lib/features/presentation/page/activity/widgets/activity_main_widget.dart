import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/activity/widgets/followers_tab_widget.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';

class ActivityMainWidget extends StatefulWidget {
  final UserEntity currentUser;
  const ActivityMainWidget({super.key, required this.currentUser});

  @override
  State<ActivityMainWidget> createState() => _ActivityMainWidgetState();
}

class _ActivityMainWidgetState extends State<ActivityMainWidget> with TickerProviderStateMixin {
  int tabIndex = 0;
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    tabController?.addListener(() {
      setState(() {
        tabIndex = tabController!.index;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {    
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titlePage('Activity'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Column(
                  children: [
                    DefaultTabController(
                      length: 5,
                      initialIndex: 0,
                      child: TabBar(
                        controller: tabController,
                        indicatorWeight: 1,  
                        labelPadding: const EdgeInsets.all(5),
                        indicatorSize: TabBarIndicatorSize.label,                                      
                        indicatorColor: backgroundColor,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,  
                        splashFactory: NoSplash.splashFactory, 
                        isScrollable: true,
                        // onTap: (value) {
                        //   print(value);
                        // },                                                       
                        tabs: [
                          labelTab(tabIndex, 'All', 0),
                          labelTab(tabIndex, 'Follows', 1),
                          labelTab(tabIndex, 'Replies', 2),
                          labelTab(tabIndex, 'Mention', 3),
                          labelTab(tabIndex, 'Reposts', 4),
                        ]
                      ),
                    ),                
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          FollowersTabWidget(currentUser: widget.currentUser),
                          nothingToSeeHereYet(),
                          nothingToSeeHereYet(),
                          nothingToSeeHereYet(),
                          nothingToSeeHereYet(),
                        ]
                      ),
                    ),                
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  Widget labelTab(int tabIndex, String title, int index){
    return Tab(      
      child: Container(                        
        width: 110,                      
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: tabIndex == index ? Colors.black : grey,                            
          ),
          color: tabIndex == index ? Colors.black : backgroundColor
        ),
        child: Text(
          title, 
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}