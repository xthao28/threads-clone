import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/page/profile/profile_page.dart';
import 'package:threads_clone/features/presentation/page/profile/single_user_profile_page.dart';
import 'package:threads_clone/injection_container.dart' as di;

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';
import '../../../../domain/usecases/user/get_current_uid_usecase.dart';
import '../../../cubit/user/user_cubit.dart';

class SingleCardUserWidget extends StatefulWidget {
  final UserEntity currentUser;
  const SingleCardUserWidget({super.key, required this.currentUser});

  @override
  State<SingleCardUserWidget> createState() => _SingleCardUserWidgetState();
}

class _SingleCardUserWidgetState extends State<SingleCardUserWidget> {
  String _currentUid = '';
  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    BlocProvider.of<UserCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: InkWell(
          splashColor: backgroundColor,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => _currentUid == widget.currentUser.uid ?
                const ProfilePage() :
                SingleUserProfilePage(
                  otherUserId: widget.currentUser.uid!
                )
              )
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              circleAvatar(18, widget.currentUser.profileUrl!), 
              sizeHor(16),         
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(
                        color: lightGreyColor,                      
                      )
                    )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,            
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(widget.currentUser.username!, 16.0, FontWeight.w600, textColorNormal),                          
                          sizeVer(3),
                          text(widget.currentUser.name!, 14.0, FontWeight.normal, grey),                          
                          sizeVer(10),
                          Text(
                            widget.currentUser.username!
                          ),                                          
                        ],
                      ),
                      if(_currentUid != widget.currentUser.uid)
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap:(){
                              setState(() {
                                BlocProvider.of<UserCubit>(context).followUnFollowUser(
                                  user: UserEntity(
                                    uid: _currentUid,
                                    otherUid: widget.currentUser.uid
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
                                child: text(
                                  widget.currentUser.followers!.contains(_currentUid) ? 'Following' : 'Follow', 
                                  16.0, 
                                  FontWeight.w600, 
                                  widget.currentUser.followers!.contains(_currentUid) ? borderColor :black
                                )                                
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
        ),
      ),
    );
  }

}