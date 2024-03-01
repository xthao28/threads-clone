// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:threads_clone/features/presentation/page/main_screen/main_screen.dart';
import 'dart:io';

import '../../../../utils/colors.dart';
import '../../../../utils/widgets.dart';
import 'widget/user_image_picker.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isSignIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _imageFile;

  void _pickedImage(File image){
    _imageFile = image;
  }

  // AnimationController? _animationController;
  // Animation<Offset>? _slideAnimation;
  // Animation<double>? _opacityAnimation;


  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: BlocConsumer<CredentialCubit, CredentialState>(
            listener: (context, credentialSate){
              if(credentialSate is CredentialSuccess){
                BlocProvider.of<AuthCubit>(context).loggedIn();
              }
              if(credentialSate is CredentialFailure){
                toast('Invalid Email and Password', Colors.red);
              }
            },
          builder: (context, credentialState){
            if(credentialState is CredentialSuccess){
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState){
                  if(authState is Authenticated){
                    return MainScreen(uid: authState.uid);
                  }else{
                    return _bodyWidget();
                  }
                }
              );            
            }else{
              return _bodyWidget();
            }
          },
        ),
      );
    }

    _bodyWidget(){
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [   
              // sizeVer(120),         
                Center(
                  child: text(
                    !_isSignIn ? 'Sign Up' : 'Sign In', 
                    26.0, 
                    FontWeight.bold, 
                    textColorNormal
                  )                  
                ),
                Center(
                  child: text(
                    !_isSignIn ? 'Customise your Threads profile' : 'Sign in to your Threads account', 
                    12.0, 
                    FontWeight.normal, 
                    grey
                  )                  
                ),
                sizeVer(100), 
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGreyColor,
                      width: 2
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
                                    title('Email'),              
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      height: 34,
                                      child: TextFormField(
                                        key: const ValueKey('email'),
                                        keyboardType: TextInputType.emailAddress,
                                        controller: _emailController,
                                        validator: (value) {
                                          if(value!.isEmpty || !value.contains("@")){
                                            return 'Please enter a valid email address.';
                                          }
                                          return null;
                                        },                        
                                        decoration: _inputDecoration('+ Email')
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if(!_isSignIn)
                                UserImagePicker(_pickedImage)
                            ],
                          ), 
                          if(!_isSignIn)                                       
                            title('Username'),
                          if(!_isSignIn)   
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 34,
                              child: TextFormField(
                                key: const ValueKey('username'),
                                keyboardType: TextInputType.name,
                                controller: _usernameController,
                                validator: (value) {
                                  if(value!.isEmpty || value.length < 4){
                                    return 'Please enter at least 4 characters.';
                                  }
                                  return null;
                                },
                                decoration: _inputDecoration('+ Username')
                              ),
                            ),
                          title('Password'),
                          Container(
                            height: 34,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              key: const ValueKey('password'),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if(value!.isEmpty || value.length < 7){
                                  return 'Password must be at least 7 characters long.';
                                }
                                return null;
                              },
                              decoration: _inputDecoration('+ Password'),        
                            ),
                          ),
                          if(!_isSignIn)                      
                            title('Bio'),  
                          if(!_isSignIn)                    
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
                sizeVer(20),
                InkWell(
                  onTap:!_isSignIn ? _signUpPage : _signInPage,
                  borderRadius: BorderRadius.circular(10),                            
                  child: Container(                                             
                    height: 48,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black
                      // border: Border.all(
                      //   color: lightGreyColor,
                      //   width: 2
                      // ),  
                    ), 
                    child: Center(
                      child: text(
                        !_isSignIn ? 'Sign Up' : 'Sign In', 
                        14.0, 
                        FontWeight.bold, 
                        white
                      )                      
                    ),             
                  ),
                ), 
                sizeVer(20),
                InkWell(
                  onTap: (){               
                    setState(() {
                      _isSignIn = !_isSignIn;
                    });
                  },
                  borderRadius: BorderRadius.circular(20),              
                  child: Container(                                             
                    height: 48,              
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),                  
                      border: Border.all(
                        color: lightGreyColor,
                        width: 2
                      ),  
                    ), 
                    child: Center(
                      child: text(
                        _isSignIn ? 'Create new account' : 'I already have an account', 
                        14.0, 
                        FontWeight.bold, 
                        black
                      )                      
                    ),             
                  ),
                ),           
              ]
            ),
          ),
        ),
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

  Widget title(String text){
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold
    ),
  );
}

  Future<void> _signUpPage() async{
    await BlocProvider.of<CredentialCubit>(context).signUpUser(
      user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        username: _usernameController.text,
        totalThreads: 0,
        totalFollowers: 0,
        totalFollowing: 0,
        link: '',
        imageFile: _imageFile,
        name: '',
        followers: [],
        following: []
      )
    ).then((value){      
      setState(() {
        _bioController.clear();
        _emailController.clear();
        _passwordController.clear();
        _usernameController.clear();
      });
    });
  }

  void _signInPage(){
    BlocProvider.of<CredentialCubit>(context).signInUser(
      email: _emailController.text, 
      password: _passwordController.text
    ).then((value){      
      setState(() {
        _emailController.clear();
        _passwordController.clear();
      });
    });
  }
}