import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/activity/activity_page.dart';
import 'package:threads_clone/features/presentation/page/home/home_page.dart';
import 'package:threads_clone/features/presentation/page/profile/profile_page.dart';
import 'package:threads_clone/features/presentation/page/search/search_page.dart';

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
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Icon(
                        currentTab == 0 ? Icons.home : Icons.home_outlined,
                        color: currentTab == 0 ? Colors.black : Colors.grey,
                        size: 32,
                      ),
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
                      child: Icon(
                        CupertinoIcons.search,
                        color: currentTab == 1 ? Colors.black : Colors.grey,
                        size: 32,
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.white10,
                      minWidth: 40,
                      onPressed: () {
                        showModalBottomSheet(
                          // shape: ,
                          context: context, 
                          builder: (BuildContext context){
                            return Container(
                              decoration: BoxDecoration(                                
                                borderRadius: BorderRadius.circular(20)
                              ),                              
                              height: 700,
                              child: const Text('Close Bottom Sheet!'),                              
                            );
                          }
                        );
                      },
                      child: const Icon(
                        Icons.edit_square,
                        color: Colors.grey,
                        size: 32,
                      ),
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
                      child: Icon(
                        currentTab == 2 ? Icons.favorite : Icons.favorite_outline,
                        color: currentTab == 2 ? Colors.black : Colors.grey,
                        size: 32,
                      ),
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
                      child: Icon(                        
                        currentTab == 3 ? Icons.person : Icons.person_outline,
                        color: currentTab == 3 ? Colors.black : Colors.grey,
                        size: 32,
                      ),
                    ),                    
                  ],
                )
              )
            ),       
            body: PageStorage(
              // ignore: sort_child_properties_last
              child: currentScreen,
              bucket: bucket,
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );    
  }
}