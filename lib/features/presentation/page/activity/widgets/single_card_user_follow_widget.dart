import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';
import '../../../../domain/usecases/user/get_current_uid_usecase.dart';
import '../../../cubit/user/user_cubit.dart';
import 'package:threads_clone/injection_container.dart' as di;

class SingleCardUserFollowWidget extends StatefulWidget {
  final UserEntity currentUser;
  final UserEntity otherUser;
  final bool isFollowers;
  const SingleCardUserFollowWidget({super.key, required this.currentUser, required this.otherUser, required this.isFollowers});

  @override
  State<SingleCardUserFollowWidget> createState() => _SingleCardUserFollowWidgetState();
}

class _SingleCardUserFollowWidgetState extends State<SingleCardUserFollowWidget> {
  String _currentUid = "";
  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5,
        top: 15        
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
                      text('${widget.otherUser.username}', 16.0, FontWeight.bold, textColorNormal),                      
                      sizeVer(3),
                      if(_currentUid != widget.otherUser.uid)
                        widget.isFollowers ? text('Followed you', 16.0, FontWeight.normal, grey) : text(widget.otherUser.name!, 16.0, FontWeight.normal, grey),
                      if(_currentUid == widget.otherUser.uid)
                      text(widget.otherUser.name!, 16.0, FontWeight.normal, grey)
                    ],
                  ),
                  if(_currentUid != widget.otherUser.uid)
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
                              color: borderColor,
                              width: 1
                            ),  
                          ),
                          child: Center(
                            child: widget.isFollowers ? 
                              text(
                                widget.otherUser.followers!.contains(widget.currentUser.uid) ? 'Following' : 'Follow', 
                                16.0, 
                                FontWeight.w600, 
                                widget.otherUser.followers!.contains(widget.currentUser.uid) ? borderColor : black,
                              )
                              : text("Unfollow", 16.0, FontWeight.w600, black)                        
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