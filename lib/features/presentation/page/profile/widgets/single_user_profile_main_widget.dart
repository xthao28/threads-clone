import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/avatar_follower_widget.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/other_user_thread_widget.dart';
import 'package:threads_clone/injection_container.dart' as di;

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';
import 'follow_widget.dart';



class SingleUserProfileMainWidget extends StatefulWidget {
  final String otherUserId;
  const SingleUserProfileMainWidget({super.key, required this.otherUserId});

  @override
  State<SingleUserProfileMainWidget> createState() => _SingleUserProfileMainWidgetState();
}
class _SingleUserProfileMainWidgetState extends State<SingleUserProfileMainWidget> with TickerProviderStateMixin {
  String _currentUid = '';

  @override
  void initState() {
    BlocProvider.of<GetOtherSingleUserCubit>(context).getOtherSingleUser(otherUid: widget.otherUserId);    
    // BlocProvider.of<ReadMyThreadsCubit>(context).readMyThreads(currentUid: widget.otherUserId);
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });    
  }

  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 3, vsync: this);
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<GetOtherSingleUserCubit, GetOtherSingleUserState>(
        builder: (context, userState){
          if(userState is GetOtherSingleUserLoaded){
            final singleUser = userState.otherUser;
            return Scaffold(
              appBar: AppBar(              
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      splashColor: backgroundColor,          
                      borderRadius: BorderRadius.circular(12),
                      onTap: (){},
                      child: const Icon(            
                        CupertinoIcons.at,
                        size: 30,
                      ),
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
                                    text(singleUser.name!, 24.0, FontWeight.bold, black),                                    
                                    sizeVer(6),
                                    Row(                            
                                      children: [
                                        text(singleUser.username!, 14.0, FontWeight.w500, black),
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
                                            child: text('threads.net', 12.0, FontWeight.normal, grey)                                            
                                          ),
                                        ),                  
                                      ],
                                    ),
                                    sizeVer(6),
                                    text(singleUser.bio!, 14.0, FontWeight.w500, black)                                    
                                  ],
                                ),
                              ),
                              circleAvatar(36, singleUser.profileUrl!),
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                AvatarFollowerWidget(currentUser: singleUser),
                                sizeHor(6),
                                InkWell(
                                  onTap: () => showMyModalBottomSheet(context, FollowWidget(currentUser: singleUser,)),
                                  child: text('${singleUser.totalFollowers} followers ', 14.0, FontWeight.normal, grey)
                                ), 
                                text("-", 14.0, FontWeight.normal, grey),
                                text(" linktr.ee/${singleUser.link}", 14.0, FontWeight.normal, grey)                                                         
                              ]
                            ),
                          ),
                          InkWell(
                            onTap:(){
                              setState(() {
                                BlocProvider.of<UserCubit>(context).followUnFollowUser(
                                  user: UserEntity(
                                    uid: _currentUid,
                                    otherUid: singleUser.uid
                                  )
                                );                                
                              });                            
                            },
                            borderRadius: BorderRadius.circular(8),                            
                            child: Container(   
                              width: double.maxFinite,                                          
                              padding: const EdgeInsets.symmetric(                              
                                vertical: 7
                              ),                    
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: singleUser.followers!.contains(_currentUid) ? Colors.white10 : Colors.black,
                                border: Border.all(
                                  color: singleUser.followers!.contains(_currentUid) ? Colors.grey.shade400 : Colors.black,
                                  width: 1
                                ),  
                              ),
                              child: Center(
                                child: text(
                                  singleUser.followers!.contains(_currentUid) ? 'Following': 'Follow', 
                                  16.0, 
                                  FontWeight.w600, 
                                  singleUser.followers!.contains(_currentUid) ? black : white
                                )                                
                              ),             
                            ),
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
                                OtherUserThreadWidget(otherUser: singleUser),
                                customMessage("No replies yet"),
                                customMessage("No reposts yet"),                                
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
          return Center(child: circularIndicatorThreads());
        }
      );
  }  
}