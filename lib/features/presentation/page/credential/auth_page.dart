import 'package:flutter/material.dart';
import 'package:threads_clone/consts.dart';
import 'dart:io';

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
  File? _profileUrl;

  void _pickedImage(File image){
    _profileUrl = image;
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
      floatingActionButton: 
        InkWell(
            onTap: (){                
              setState(() {
                _isSignIn = !_isSignIn;
              });
            },
            borderRadius: BorderRadius.circular(20),              
            child: Padding(              
              padding: const EdgeInsets.only(left: 32),
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
                  child: Text(
                    _isSignIn ? 'Create new account' : 'I already have an account', 
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                ),             
              ),
            ),
          ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [   
            sizeVer(120),         
            Center(
              child: Text(
                !_isSignIn ? 'Sign Up' : 'Sign In',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Center(
              child: Text(
                !_isSignIn ? 'Customise your Threads profile' : 'Sign in to your Threads account',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(153, 153, 153, 1)
                ),
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
                                    decoration: const InputDecoration(                                                 
                                      hintText: '+ Email', 
                                      hintStyle: TextStyle(
                                        fontSize: 12
                                      ), 
                                      contentPadding: EdgeInsets.only(top: -20), 
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1, 
                                          color: lightGreyColor
                                        )
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1, 
                                          color: lightGreyColor
                                        )
                                      )
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            decoration: const InputDecoration(
                              hintText: '+ Username',
                              hintStyle: TextStyle(
                                fontSize: 12
                              ),
                              contentPadding: EdgeInsets.only(top: -20), 
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1, 
                                    color: lightGreyColor
                                  )
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1, 
                                    color: lightGreyColor
                                  )
                                )
                            ),
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
                          decoration: const InputDecoration(
                            hintText: '+ Password',
                            hintStyle: TextStyle(
                              fontSize: 12
                            ),
                            contentPadding: EdgeInsets.only(top: -20),                             
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1, 
                                  color: lightGreyColor
                                )
                              ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 1, 
                                color: lightGreyColor
                              )
                            )
                          ),                    
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
              onTap: (){                                
              },
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
                  child: Text(
                    !_isSignIn ? 'Sign Up' : 'Sign In', 
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                ),             
              ),
            ),            
          ]
        ),
      ),
    );
  }
}