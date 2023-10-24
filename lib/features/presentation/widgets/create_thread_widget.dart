import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import '../../../consts.dart';

class CreateThreadWidget extends StatefulWidget {
  final UserEntity currentUser;
  const CreateThreadWidget({super.key, required this.currentUser});

  @override
  State<CreateThreadWidget> createState() => _CreateThreadWidgetState();
}

class _CreateThreadWidgetState extends State<CreateThreadWidget> {
  final TextEditingController _descriptionController = TextEditingController();  
  File? _pickedImage;
  double? height = 0.0;
  final GlobalKey _globalKey = GlobalKey();

  // @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     height = _globalKey.currentContext!.size?.height;      
  //     setState(() {});
  //   });
  //   super.initState();
  // }
  

  Future selectImage() async{
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );

    if(pickedImageFile == null){
      // ignore: avoid_print
      print('No image has been selected');
      return;
    }
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();  
    _pickedImage = null;  
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double checkKeyBoard = MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Stack(
        children:[ 
          Container( 
            padding: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 60,
                        child: Text(                                            
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black                                         
                          ),                                            
                        ),
                      ),
                    ),
                    const Text(
                      'New thread',                                        
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),     
                    sizeHor(70)
                  ],
                ),
                const Divider(
                  color: lightGreyColor,                                    
                ),                
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: checkKeyBoard == 0 ? width*0.8 : checkKeyBoard,
                  child: SingleChildScrollView(
                    child: Container(                    
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  circleAvatar(19, widget.currentUser.profileUrl!),
                                  sizeVer(12),                              
                                  SizedBox(
                                    height: height == 0 && _pickedImage == null ? 
                                    60 : 
                                    height == 0 && _pickedImage != null ? 
                                    280 : 
                                    height != 0 && _pickedImage == null ?
                                    12 + height! :
                                    12 + height! + 230
                                    ,                                                                
                                    child: const VerticalDivider(                                  
                                      thickness: 2,
                                      color: lightGreyColor,
                                    ),
                                  )
                                ],
                              ),
                              sizeHor(10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.currentUser.username!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    TextFormField( 
                                      key: _globalKey,                                 
                                      controller: _descriptionController,                                                                                                    
                                      keyboardType: TextInputType.multiline, 
                                      maxLines: null,                                                                  
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Start a thread...',
                                        border: InputBorder.none
                                      ),  
                                      onChanged: (text){
                                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                          height = _globalKey.currentContext!.size?.height;
                                          setState(() {});                                      
                                          }
                                        );
                                      },                                                                                                                                                
                                    ),
                                    sizeVer(8),
                                    InkWell(
                                      splashColor: backgroundColor,
                                      onTap: selectImage,
                                      child: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                        color: grey,
                                      ),
                                    ),
                                    sizeVer(20),
                                    _pickedImage != null ? 
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.file(
                                              FileImage(_pickedImage!).file,
                                              width: 200,
                                              height: 210,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            right: 3,
                                            top: 3,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _pickedImage = null;
                                                });
                                              },
                                              icon: const CircleAvatar(
                                                radius: 16,
                                                backgroundColor: Colors.black54,
                                                child: Icon(
                                                  CupertinoIcons.xmark,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            )
                                          )
                                        ]
                                      ) : 
                                      Container(),
                                      
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: circleAvatar(8, widget.currentUser.profileUrl!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),                
              ]
            )
          ),
          Positioned(
            bottom: checkKeyBoard,
            left: 0,
            right: 0,
            child: SizedBox(              
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){}, 
                      child: const Text('Anyone can reply')
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory
                      ),
                      onPressed: _submitThread,
                      child: Container(  
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: grey
                        ),                      
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10
                          ),
                          child: Text(
                            'Post',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            )
          )
        ]
      ),                              
    );
  }
  _submitThread(){
    setState(() {
      di.sl<UploadImageToStorageUseCase>().call(_pickedImage!, true, 'threads').then((imageUrl) {
        _createThread(imageUrl: imageUrl);
      });
    });
  }

  Future<void> _createThread({required String imageUrl}) async{
    BlocProvider.of<ThreadCubit>(context).createThread(
      thread: ThreadEntity(
        creatorUid: widget.currentUser.uid,
        createdAt: Timestamp.now(),
        threadId: const Uuid().v1(),
        totalComments: 0,
        totalLikes: 0,
        likes: const [],        
        description: _descriptionController.text,
        userProfileUrl: widget.currentUser.profileUrl,
        username: widget.currentUser.username,
        threadImageUrl: imageUrl
      )
    ).then((value) {
      setState(() {
        _descriptionController.clear();
      });      
    });
  }
}