import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

import '../../../cubit/user/user_cubit.dart';

class SingleCardUserFollowWidget extends StatefulWidget {
  final UserEntity currentUser;
  final UserEntity otherUser;
  const SingleCardUserFollowWidget({super.key, required this.currentUser, required this.otherUser});

  @override
  State<SingleCardUserFollowWidget> createState() => _SingleCardUserFollowWidgetState();
}

class _SingleCardUserFollowWidgetState extends State<SingleCardUserFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5,        
      ),
      margin: const EdgeInsets.only(
        bottom: 15
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          circleAvatar(18, widget.otherUser.profileUrl.toString()),
          sizeHor(10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(
                    color: lightGreyColor,                      
                  )
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.otherUser.username}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      sizeVer(3),
                      const Text(
                        'Followed you',
                        style: TextStyle(
                          fontSize: 16,
                          color: grey
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap:(){
                        setState(() {
                          BlocProvider.of<UserCubit>(context).followUnFollowUser(
                            user: UserEntity(
                              uid: widget.currentUser.uid,
                              otherUid: widget.otherUser.uid
                            )
                          );
                        });  
                      },
                      borderRadius: BorderRadius.circular(8),                            
                      child: Container(                                             
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 7
                        ),                    
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:  Colors.white10,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1
                          ),  
                        ),
                        child: Center(
                          child: Text(
                            widget.otherUser.followers!.contains(widget.currentUser.uid) ? 'Following' : 'Follow', 
                            style: TextStyle(
                              color: widget.otherUser.followers!.contains(widget.currentUser.uid) ? Colors.grey.shade400 : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),
                          ),
                        ),             
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}