import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/domain/usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/user/user_cubit.dart';
import '../../../../../utils/colors.dart';
import 'package:threads_clone/injection_container.dart' as di;

import '../../../../../utils/widgets.dart';


class EditProfile extends StatefulWidget {
  final UserEntity currentUser;
  const EditProfile({super.key, required this.currentUser});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // ignore: prefer_final_fields
  bool _isUpdating = false;
  TextEditingController? _nameController;
  TextEditingController? _bioController;
  TextEditingController? _linkController;

  File? _imageFile;  
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
      _imageFile = File(pickedImageFile.path);
    });
  }
  
  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.name);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    _linkController = TextEditingController(text: widget.currentUser.link);

    super.initState();
  }

  

  @override
  void dispose() {
    _bioController?.dispose();
    _linkController?.dispose();
    _nameController?.dispose();
    _imageFile = null;    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget title(String text){
      return Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold
        ),
      );
    }
    // double checkKeyBoard = MediaQuery.of(context).viewInsets.bottom;
    // double width = MediaQuery.of(context).size.width;
    String? imageUser = widget.currentUser.profileUrl;
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container( 
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
                  child: text('Cancel', 16.0, FontWeight.normal, black)                  
                ),
                text('Edit profile', 16.0, FontWeight.bold, black),                   
                _isUpdating == false ? 
                  TextButton(
                    onPressed: _submitData,
                    child: text('Save', 16.0, FontWeight.normal, Colors.blue)                      
                  ) :
                  const CircularProgressIndicator()
              ],
            ),
            const Divider(
              color: lightGreyColor,                                    
            ),                
            Padding(
              padding: const EdgeInsets.only(
                // top: checkKeyBoard == 0.0 ? width*0.4 : width*0.2 ,
                right: 6,
                left: 6
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: lightGreyColor,
                    width: 1
                  ),                
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    right: 16,
                    left: 16,
                    bottom: 0
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  
                        Row(                        
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title('Username'),              
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 0),
                                    height: 32,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.lock,
                                          size: 14,
                                          color: Colors.black,                                          
                                        ),
                                        Text('@${widget.currentUser.username.toString()}'),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTap: selectImage,
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: const Color.fromRGBO(242, 239, 240, 1),
                                backgroundImage: 
                                  _imageFile != null &&  imageUser == null ? 
                                  FileImage(_imageFile!) : 
                                  _imageFile == null &&  imageUser != null ?
                                  NetworkImage(imageUser) :
                                  _imageFile != null &&  imageUser != null ?
                                  FileImage(_imageFile!) as ImageProvider :
                                  null,
                                child: _imageFile == null && imageUser == null ? const Icon(                                
                                  CupertinoIcons.person_add_solid,
                                  size: 32,
                                  color: Colors.black,
                                ) : null,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: lightGreyColor,
                          ),
                        ),
                        title('Name'),
                        Container(
                          height: 34,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.name,                                                
                            controller: _nameController,                        
                            decoration: _inputDecoration('+ Name'),        
                          ),
                        ),                                                                     
                        title('Link'),
                        Container(
                          height: 34,
                          margin: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.url,                                                
                            controller: _linkController,                        
                            decoration: _inputDecoration('+ Link'),        
                          ),
                        ),                      
                        title('Bio'),                      
                        TextFormField(
                          key: const ValueKey('bio'),
                          keyboardType: TextInputType.text,
                          controller: _bioController,
                          validator: (value) {
                            if(value!.isEmpty || value.length < 4){
                              return 'Please enter at least 4 characters.';                      
                            }
                            return null;                    
                          },
                          decoration: const InputDecoration(
                            hintText: '+ Write Bio',
                            hintStyle: TextStyle(
                              fontSize: 12
                            ),
                            contentPadding: EdgeInsets.only(top: -20), 
                            border: InputBorder.none                          
                          ),
                        ),                                                                
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]
        ),
      )
    ); 
  }
  InputDecoration _inputDecoration(String text){
    return InputDecoration(
      hintText: text,
      hintStyle: const TextStyle(
        fontSize: 12
      ),
      contentPadding: const EdgeInsets.only(top: -20),                             
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1, 
            color: lightGreyColor
          )
        ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1, 
          color: lightGreyColor
        )
      )
    );                    
  }

  _submitData(){
    setState(() {
      _isUpdating == true;
    });
    if(_imageFile == null){
      _editProfile('');
    }else{
      di.sl<UploadImageToStorageUseCase>().call(_imageFile!, false, 'profileImages').then((profileUrl) {
        _editProfile(profileUrl);
      });
    }
  }

  _editProfile(String profileUrl){
    BlocProvider.of<UserCubit>(context).updateUser(
      user: UserEntity(
        uid: widget.currentUser.uid,
        name: _nameController!.text,
        bio: _bioController!.text,
        link: _linkController!.text,
        // ignore: unnecessary_null_comparison
        profileUrl: profileUrl == null ? profileUrl : widget.currentUser.profileUrl
      )
    ).then((value) => _clear());
  }

  _clear(){
    setState(() {
      _bioController!.clear();
      _nameController!.clear();
      _linkController!.clear();
    });
    Navigator.pop(context);    
  }
}