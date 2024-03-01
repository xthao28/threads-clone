import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/avatar_follower_widget.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/edit_profile.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/my_threads_widget.dart';
import 'package:threads_clone/features/presentation/page/setting/setting_page.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';



class ProfileMainWidget extends StatefulWidget {
  final UserEntity currentUser;

  const ProfileMainWidget({super.key, required this.currentUser});

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> with TickerProviderStateMixin {  
  // @override
  // void initState() {
  //   BlocProvider.of<ReadMyThreadsCubit>(context).readMyThreads(currentUid: widget.currentUser.uid!);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 3, vsync: this);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(          
        //   splashColor: backgroundColor,          
        //   onTap: (){},          
        //   child: const Icon(
        //     CupertinoIcons.globe,
        //     size: 30,
        //   ),
        // ),
        actions: [
          InkWell(
            splashColor: backgroundColor,          
            borderRadius: BorderRadius.circular(12),
            onTap: (){},
            child: const Icon(            
              CupertinoIcons.at,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(  
              splashColor: backgroundColor,                      
              onTap: () {                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingPage(currentUser: widget.currentUser)));
              },          
              child: hamburger()
            ),
          ),          
        ],
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SizedBox(        
        child: Column(
          children: 
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    sizeVer(10),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: width/1.45,
                        child: Column(     
                          crossAxisAlignment: CrossAxisAlignment.start,           
                          children: [
                            text(widget.currentUser.name!, 24.0, FontWeight.bold, black),                            
                            sizeVer(6),
                            Row(                            
                              children: [
                                text(widget.currentUser.username!, 14.0, FontWeight.w500, black),                                
                                sizeHor(10),
                                InkWell(
                                  onTap: (){},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                      color: lightGreyColor
                                    ),                        
                                    child: text('threads.net', 12.0, FontWeight.normal, grey),                                     
                                  ),
                                ),                  
                              ],
                            ),
                            sizeVer(6),
                            text(
                              widget.currentUser.bio!, 
                              14.0, 
                              FontWeight.w500, 
                              black
                            )                            
                          ],
                        ),
                      ),
                      circleAvatar(36, widget.currentUser.profileUrl!),
                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        AvatarFollowerWidget(currentUser: widget.currentUser),
                        sizeHor(6),
                        text(
                          '${widget.currentUser.totalFollowers} followers - linktr.ee/${widget.currentUser.link}', 
                          14.0, 
                          FontWeight.normal, 
                          grey
                        )                                                       
                      ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:() => showMyModalBottomSheet(
                          context, 
                          EditProfile(currentUser: widget.currentUser)
                        ),
                        borderRadius: BorderRadius.circular(8),                            
                        child: Container(                                             
                          padding:const EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 7
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white10,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1
                            ),  
                          ),
                          child: Center(
                            child: text('Edit profile', 16.0, FontWeight.w600, black)                            
                          ),             
                        ),
                      ), 
                      InkWell(
                        onTap:(){},
                        borderRadius: BorderRadius.circular(8),                            
                        child: Container(                                             
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 7
                          ),                    
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white10,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1
                            ),  
                          ),
                          child: Center(
                            child: text('Share profile', 16.0, FontWeight.w600, black)                            
                          ),             
                        ),
                      ),                     
                    ],
                  ),
                ]
                ),
              ),
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
                        Tab(child: labelTab('Threads')),
                        Tab(child: labelTab('Replies'),),
                        Tab(child: labelTab('Reposts')),
                      ]
                    ),
                  ),                
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        MyThreadsWidget(currentUser: widget.currentUser),
                        customMessage("You haven't posted any replies yet"),
                        customMessage("You haven't reposted any replies yet"),
                      ]
                    ),
                  ),                
                ],
              ),
            )
          ]
        ),        
      )
    );    
  }
 
  Widget hamburger(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 2,                                        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Colors.black,
          ),
        ),
        sizeVer(8),
        Container(
          width: 16,
          height: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Colors.black,
          ),
        )
      ],
    );
  }  
}