import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/injection_container.dart' as di;
import 'package:uuid/uuid.dart';

import '../../../utils/colors.dart';
import '../../../utils/widgets.dart';

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
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 60,
                        child: text('Cancel', 16.0, FontWeight.normal, black)
                      ),
                    ),
                    text('New thread', 16.0, FontWeight.bold, textColorNormal),                         
                    sizeHor(70)
                  ],
                ),
                const Divider(
                  color: lightGreyColor,        
                  height: 1,                            
                ),                
                SizedBox(
                  // padding: const EdgeInsets.only(top: 0),
                  height: checkKeyBoard == 0 ? width*0.8 : checkKeyBoard,
                  child: SingleChildScrollView(
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
                                circleAvatar(19, widget.currentUser.profileUrl!),
                                sizeVer(6),
                                const Expanded(
                                  child: VerticalDivider(
                                    width: 1,
                                    thickness: 2,
                                    color: lightGreyColor,
                                  ),
                                ),
                                sizeVer(6),
                                circleAvatar(8, widget.currentUser.profileUrl!),
                              ],
                            ),
                            // AvatarThreadWidget(thread: widget.thread),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
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
                                      controller: _descriptionController,                                                                                                    
                                      keyboardType: TextInputType.multiline, 
                                      maxLines: null,                                                                  
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        hintText: 'Start a thread...',
                                        border: InputBorder.none
                                      ),                                                                                                                                                                                      
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
                                    sizeVer(10),
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
                            )
                          ],
                        ),
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
    if(_pickedImage == null){
      _createThread(imageUrl: '');
    }else{
    di.sl<UploadImageToStorageUseCase>().call(_pickedImage!, true, 'threads').then((imageUrl) {
      _createThread(imageUrl: imageUrl);
    }).then((value) {      
        _descriptionController.clear();      
      }).then((value) => Navigator.pop(context));   
    } 
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
    );
  }
}

