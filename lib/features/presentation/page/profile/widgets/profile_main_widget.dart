import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/edit_profile.dart';
import 'package:threads_clone/features/presentation/page/profile/widgets/my_threads_widget.dart';
import 'package:threads_clone/features/presentation/page/setting/setting_page.dart';



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
                            Text(
                              widget.currentUser.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black
                              ),
                            ),
                            sizeVer(6),
                            Row(                            
                              children: [
                                Text(
                                  widget.currentUser.username!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
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
                                    child: const Text(
                                      'threads.net',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                ),                  
                              ],
                            ),
                            sizeVer(6),
                            Text(
                              widget.currentUser.bio!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),
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
                        SizedBox(
                          width: 50,
                          child: Stack(
                            children: const [
                              Positioned(
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.blue
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.red
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 24,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 11,
                                    backgroundColor: Colors.yellow
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        sizeHor(6),
                        Text(
                          '${widget.currentUser.totalFollowers} followers - linktr.ee/${widget.currentUser.link}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        ),                                
                      ]
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:(){
                          showModalBottomSheet(  
                            isScrollControlled: true,                        
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)
                              )
                            ),
                            context: context, 
                            builder: (BuildContext context){
                              return EditProfile(currentUser: widget.currentUser);
                            }
                          );
                        },
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
                          child: const Center(
                            child: Text(
                              'Edit profile', 
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
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
                          child: const Center(
                            child: Text(
                              'Share profile', 
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                              ),
                            ),
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
  Widget labelTab(String text){
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16
      ),
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
  Widget customMessage(String message){
    return Center(
      child: Text(
        message,
        style: const TextStyle(
          color: grey,
          fontSize: 14
        ),
      )
    );
  }
}