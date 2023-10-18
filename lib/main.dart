import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/page/credential/auth_page.dart';
import 'package:threads_clone/features/presentation/page/main_screen/main_screen.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<GetOtherSingleUserCubit>())
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,          
        ),
        initialRoute: '/',
        routes: {
          '/' :(context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authSate){
                if(authSate is Authenticated){
                  return MainScreen(uid: authSate.uid);
                }else{
                  return const AuthPage();
                }
              }
            );
          }
        },
      )
    );
  }
}

