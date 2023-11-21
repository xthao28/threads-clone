import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/consts.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/usecases/user/get_current_uid_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/page/profile/profile_page.dart';
import 'package:threads_clone/features/presentation/page/profile/single_user_profile_page.dart';
import 'package:threads_clone/injection_container.dart' as di;

class SingleCardThreadWidget extends StatefulWidget {
  final ThreadEntity thread;
  const SingleCardThreadWidget({super.key, required this.thread});


  @override
  State<SingleCardThreadWidget> createState() => _SingleCardThreadWidgetState();
}

class _SingleCardThreadWidgetState extends State<SingleCardThreadWidget> {

  // ignore: unused_field
  String _currentUid = '';

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
    return  Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: lightGreyColor,)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,                
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundColor: grey,
                    backgroundImage: NetworkImage(widget.thread.userProfileUrl!),
                  ),
                  sizeVer(6),
                  const Expanded(
                    child: VerticalDivider(
                      width: 1,
                      thickness: 2,
                      color: lightGreyColor,
                    ),
                  ),
                  sizeVer(6),
                  SizedBox(
                    width: 30,
                    child: Stack(
                      children: const [
                        Positioned(
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.blue
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,                                   
                    children: [
                      Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,                    
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => _currentUid == widget.thread.creatorUid ?
                                  const ProfilePage() :
                                  SingleUserProfilePage(otherUserId: widget.thread.creatorUid.toString())
                                )
                              );
                            },
                            child: Text(
                              widget.thread.username!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ),
                          Row(                          
                            children: [
                              Text(
                                formatTimestamp(widget.thread.createdAt!),                              
                                style: const TextStyle(
                                  color: grey,
                                ),
                              ),
                              sizeHor(5),
                              if(_currentUid == widget.thread.creatorUid)
                                InkWell(
                                  onTap: _showOption,                                                              
                                  child: const Icon(
                                    Icons.more_horiz
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(                        
                          widget.thread.description!,                                                    
                          overflow: TextOverflow.clip,                          
                          style: const TextStyle(
                            fontSize: 16,                            
                          ),                        
                        ),
                      ), 
                      widget.thread.threadImageUrl != '' ? 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),                        
                          child: CachedNetworkImage(
                            imageUrl: widget.thread.threadImageUrl!,
                            placeholder: (context, url) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),                              
                              width: double.maxFinite, 
                              height: 200,                         
                              decoration: BoxDecoration(
                                color: lightGreyColor,
                                borderRadius: BorderRadius.circular(8)
                              ),
                            ),                            
                           )
                        ),
                      ) : 
                      Container(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _likeThread,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: Image.asset(
                                  'assets/images/${widget.thread.likes!.contains(_currentUid) ? 'heart-red' : 'like'}.png',
                                  width: 22.5,
                                ),
                              ),
                            ),
                            iconFile('reply'),
                            iconFile('repost'),
                            iconFile('paperplane')
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.thread.totalComments} replies',
                            style: const TextStyle(
                              fontSize: 16,
                              color: grey
                            ),
                          ),
                          const Text(
                            ' · ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: grey
                            ),
                          ),
                          Text(
                            '${widget.thread.totalLikes} likes',
                            style: const TextStyle(
                              fontSize: 16,
                              color: grey
                            ),
                          )
                        ],
                      )
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

  Widget iconFile(String nameFile){
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Image.asset(
        'assets/images/$nameFile.png',
        width: 22.5,
      ),
    );
  }
  _likeThread(){
    BlocProvider.of<ThreadCubit>(context).likeThread(
      thread: ThreadEntity(
        threadId: widget.thread.threadId
      )
    );    
  }

  Future _showOption(){
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      context: context, 
      builder: (BuildContext context){
        return FractionallySizedBox(
          heightFactor: 0.15,
          child: Container(
            padding: const EdgeInsets.only(
              top: 7,
              left: 16,
              right: 16,              
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5/2),
                    color: grey
                  ),
                ),
                sizeVer(15),
                InkWell(
                  splashColor: backgroundColor,
                  onTap: _deleteThread,
                  child: Container(                                      
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Icon(
                            CupertinoIcons.delete,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  _deleteThread(){
    BlocProvider.of<ThreadCubit>(context).deleteThread(
      thread: ThreadEntity(
        threadId: widget.thread.threadId
      )
    ).then((value) => Navigator.pop(context));
  }
}