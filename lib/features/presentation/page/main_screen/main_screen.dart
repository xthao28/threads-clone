
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/activity_page.dart';
import 'package:threads_clone/features/presentation/page/home/home_page.dart';
import 'package:threads_clone/features/presentation/page/search/search_page.dart';
import 'package:threads_clone/features/presentation/page/thread/thread_page.dart';
import 'package:threads_clone/features/presentation/widgets/bottom_navigation_bar/bottom_navigation.dart';

import '../../../../utils/widgets.dart';
import '../../widgets/bottom_navigation_bar/tab_item.dart';
import '../../widgets/create_thread_widget.dart';
import '../profile/profile_page.dart';







class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static String currentUid = '';
  static int currentIndex = 0;  
  @override
  void initState() {       
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);                  
    super.initState();             
  }   
  final List<TabItem> tabs = [
    TabItem(
      tabName: '',        
      page: const HomePage()
    ),
    TabItem(
      tabName: '',       
      page: const SearchPage()
    ),
    TabItem(
      tabName: '',       
      page: const ThreadPage()
    ),
    TabItem(
      tabName: '',        
      page: const ActivityPage()
    ),
    TabItem(
      tabName: '',  
      page: const ProfilePage()
    ),
  ]; 

  

  MainScreenState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {      
    
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserSate) {
        if(getSingleUserSate is GetSingleUserLoaded){
          final currentUser = getSingleUserSate.user;
          void selectPage(int index){
            if (index == currentIndex) {
              // pop to first route
              // if the user taps on the active tab
              tabs[index].key.currentState!.popUntil((route) => route.isFirst);
            } else {
              // update the state
              // in order to repaint               
              if(index == 2) {
                showMyModalBottomSheet(context, CreateThreadWidget(currentUser: currentUser,));                
              } else{ 
                setState(() {
                  currentIndex = index;                
                });                           
              }            
            } 
          }  
          return WillPopScope(
            onWillPop: () async {
              final isFirstRouteIncurrentIndex =
                  !await tabs[currentIndex].key.currentState!.maybePop();
              if (isFirstRouteIncurrentIndex) {
                // if not on the 'main' tab
                if (currentIndex != 0) {
                  // select 'main' tab
                  selectPage(0);
                  // back button handled by app
                  return false;
                }
              }
              // let system handle back button if we're on the first route
              return isFirstRouteIncurrentIndex;
            },
            child: Scaffold(   
              body: 
                IndexedStack(
                  index: currentIndex,
                  children: tabs.map((e) => e.page).toList()
                ),                     
              bottomNavigationBar: BottomNavigation(
                onSelectTab: selectPage, 
                tabs: tabs
              )
            ),
          );
        }
        return Scaffold(body: Center(child: circularIndicatorThreads()));
      }
    );    
  }
}

