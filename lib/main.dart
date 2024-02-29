import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_my_threads/read_my_threads_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_single_thread/read_single_thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_followers/get_followers_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_following/get_following_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:threads_clone/features/presentation/page/credential/auth_page.dart';
import 'package:threads_clone/features/presentation/page/main_screen/main_screen.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'injection_container.dart' as di;

Future main() async{
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
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<ThreadCubit>()..readThreads(thread: const ThreadEntity())),
        BlocProvider(create: (_) => di.sl<ReadSingleThreadCubit>()),    
        BlocProvider(create: (_) => di.sl<CommentCubit>()),
        BlocProvider(create: (_) => di.sl<ReadMyThreadsCubit>()),    
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<GetOtherSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<GetFollowersCubit>()),
        BlocProvider(create: (_) => di.sl<GetFollowingCubit>())
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,          
        ),
        // onGenerateRoute: OnGenerateRoute.route,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState){                
            if(authState is Authenticated){                  
              return MainScreen(uid: authState.uid);
            }else{
              return const AuthPage();
            }
          }
        )       
      )
    );
  }
}

