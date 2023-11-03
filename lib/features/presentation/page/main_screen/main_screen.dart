
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/activity_page.dart';
import 'package:threads_clone/features/presentation/page/home/home_page.dart';
import 'package:threads_clone/features/presentation/page/profile/profile_page.dart';
import 'package:threads_clone/features/presentation/page/search/search_page.dart';
import 'package:threads_clone/features/presentation/widgets/create_thread_widget.dart';





class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentTab= 0;


  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();


  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);        
    super.initState();
  }

  @override
  Widget build(BuildContext context) {            
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserSate) {
        if(getSingleUserSate is GetSingleUserLoaded){
          final currentUser = getSingleUserSate.user;
          return Scaffold(                        
            bottomNavigationBar: BottomAppBar(
              color: Colors.white10,
              elevation: 0,              
              notchMargin: 10,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              const HomePage(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Image.asset(
                        'assets/images/${currentTab == 0 ? 'feed-fill.png' : 'feed.png'}',
                        width: 28
                      )
                    ),
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              const SearchPage(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Image.asset(
                        'assets/images/${currentTab == 1 ? 'explore-fill.png' : 'explore.png'}',
                        width: 28
                      )
                    ),
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        showModalBottomSheet(  
                          isScrollControlled: true,                        
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          context: context, 
                          builder: (BuildContext context){
                            return CreateThreadWidget(currentUser: currentUser);
                          }
                        );
                      },
                      child: Image.asset(
                        'assets/images/write.png',
                        width: 28
                      )
                    ),
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              ActivityPage(currentUser: currentUser,); // if user taps on this dashboard tab will be active
                          currentTab = 2;
                        });
                      },
                      child: Image.asset(
                        'assets/images/${currentTab == 2 ? 'heart-fill.png' : 'heart.png'}',
                        width: 28
                      )
                    ),
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              ProfilePage(currentUser: currentUser); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Image.asset(
                        'assets/images/${currentTab == 3 ? 'account-fill.png' : 'account.png'}',
                        width: 28
                      )
                    ),                    
                  ],
                )
              )
            ),       
            body: 
              PageStorage(
                bucket: bucket, 
              child: currentScreen
              )            
          );
        }
        return Scaffold(body: Center(child: circularIndicatorThreads()));
      }
    );    
  }
}