import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';


class ProfileMainWidget extends StatefulWidget {
  final UserEntity currentUser;

  const ProfileMainWidget({super.key, required this.currentUser});

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> with TickerProviderStateMixin {  
  @override
  Widget build(BuildContext context) {
    final TabController tabController = TabController(length: 2, vsync: this);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(          
          splashColor: Colors.white10,          
          onTap: (){},          
          child: const Icon(
            CupertinoIcons.globe,
            size: 30,
          ),
        ),
        actions: [
          InkWell(
            splashColor: Colors.white10,          
            borderRadius: BorderRadius.circular(12),
            onTap: (){},
            child: const Icon(            
              CupertinoIcons.bolt_horizontal_circle,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(  
              splashColor: Colors.white10,                      
              onTap: () {
                // BlocProvider.of<AuthCubit>(context).loggedOut();
              },          
              child: const Icon(
                CupertinoIcons.line_horizontal_3_decrease,
                size: 28,
              ),
            ),
          ),          
        ],
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: 
            [
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
                      const Text(
                        'Xuân Thảo',
                        style: TextStyle(
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
                      const Text(
                        'Passionate about art, photography, and all things creative 🎨✨',
                        style: TextStyle(
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
                    '${widget.currentUser.totalFollowers} followers - linktr.ee/xuanthao_28',
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
                  onTap:(){},
                  borderRadius: BorderRadius.circular(8),                            
                  child: Container(                                             
                    padding:const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 7
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black
                    ),
                    child: const Center(
                      child: Text(
                        'Edit profile', 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
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
                      horizontal: 42,
                      vertical: 7
                    ),                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white10,
                      border: Border.all(
                        color: lightGreyColor,
                        width: 2
                  ),  
                    ),
                    child: const Center(
                      child: Text(
                        'Share profile', 
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                    ),             
                  ),
                ),                     
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(text: 'Threads',),
                      Tab(text: 'Replies',),
                    ]
                  ),                
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        Text('Threads Tab'),
                        Text('Replies Tab')
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
  Widget circleAvatar(double radius, String url) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        // ignore: unnecessary_null_comparison
        backgroundImage: url != '' ? NetworkImage(url) : null,
        radius: radius,
      );
    }
}