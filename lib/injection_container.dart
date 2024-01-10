import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:threads_clone/features/domain/usecases/comment/create_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/like_comment_usecase.dart';
import 'package:threads_clone/features/domain/usecases/comment/read_comments_usecase.dart';
import 'package:threads_clone/features/domain/usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/create_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/delete_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/like_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_my_threads_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_single_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/read_threads_usecase.dart';
import 'package:threads_clone/features/domain/usecases/thread/update_thread_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/follow_un_follow_user_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/get_followers_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/get_following_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/get_single_other_user_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/get_single_user_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/get_users_usecase.dart';
import 'package:threads_clone/features/domain/usecases/user/update_user_usecase.dart';
import 'package:threads_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/reply/reply_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_my_threads/read_my_threads_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/read_single_thread/read_single_thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/thread/thread_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_followers/get_followers_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_following/get_following_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_other_single_user/get_other_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:threads_clone/features/presentation/cubit/user/user_cubit.dart';
import 'features/data/data_source/remote_data_source.dart';
import 'features/domain/repository/firebase_repository.dart';
import 'features/domain/usecases/reply/create_reply_usecase.dart';
import 'features/domain/usecases/reply/delete_reply_usecase.dart';
import 'features/domain/usecases/reply/like_reply_usecase.dart';
import 'features/domain/usecases/reply/read_replies_usecase.dart';
import 'features/domain/usecases/user/get_current_uid_usecase.dart';
import 'features/domain/usecases/user/is_sign_in_usecase.dart';
import 'features/domain/usecases/user/sign_in_user_usecase.dart';
import 'features/domain/usecases/user/sign_out_usecase.dart';
import 'features/domain/usecases/user/sign_up_user_usecase.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'features/presentation/cubit/credential/credential_cubit.dart';

import 'features/data/data_source/remote_data_source_impl.dart';
import 'features/data/repository/firebase_repository_impl.dart';


final sl = GetIt.instance;

Future<void> init() async{

//Cubit
  sl.registerFactory(() => AuthCubit(
    signOutUseCase: sl.call(), 
    isSignInUseCase: sl.call(), 
    getCurrentUidUseCase: sl.call())
  );

  sl.registerFactory(() => CredentialCubit(
    signInUserUseCase: sl.call(), 
    signUpUserUseCase: sl.call())
  );

  sl.registerFactory(() => UserCubit(
    getUsersUseCase: sl.call(), 
    updateUserUseCase: sl.call(),
    followUnFollowUserUseCase: sl.call()
  ));

  sl.registerFactory(() => ThreadCubit(
    createThreadUseCase: sl.call(), 
    deleteThreadUseCase: sl.call(), 
    likeThreadUseCase: sl.call(), 
    readThreadsUseCase: sl.call(),    
    updateThreadUseCase: sl.call()
  ));

  sl.registerFactory(() => CommentCubit(
    createCommentUseCase: sl.call(), 
    deleteCommentUseCase: sl.call(), 
    likeCommentUseCase: sl.call(), 
    readCommentsUseCase: sl.call()
  ));

  sl.registerFactory(() => ReplyCubit(
    createReplyUseCase: sl.call(), 
    deleteReplyUseCase: sl.call(), 
    likeReplyUseCase: sl.call(), 
    readRepliesUseCase: sl.call()
  ));

  sl.registerFactory(() => ReadSingleThreadCubit(
    readSingleThreadUseCase: sl.call()
  ));

  sl.registerFactory(() => ReadMyThreadsCubit(
    readMyThreadsUseCase: sl.call()
  ));

  sl.registerFactory(() => GetFollowersCubit(
    getFollowersUseCase: sl.call()
  ));

  sl.registerFactory(() => GetFollowingCubit(
    getFollowingUseCase: sl.call()
  ));

  sl.registerFactory(() => GetOtherSingleUserCubit(
    getSingleOtherUserUseCase: sl.call()
  ));
  
  sl.registerFactory(() => GetSingleUserCubit(
    getSingleUserUseCase: sl.call()
  ));

//User

  sl.registerLazySingleton(() => GetCurrentUidUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetSingleOtherUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetFollowersUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => GetFollowingUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => FollowUnFollowUserUseCase(firebaseRepository: sl.call()));
  

//Thread
  sl.registerLazySingleton(() => CreateThreadUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => DeleteThreadUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => LikeThreadUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => ReadSingleThreadUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => ReadThreadsUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => UpdateThreadUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(() => ReadMyThreadsUseCase(firebaseRepository: sl.call()));


//Comment
sl.registerLazySingleton(() => CreateCommentUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => DeleteCommentUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => LikeCommentUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => ReadCommentsUseCase(firebaseRepository: sl.call()));


//Reply
sl.registerLazySingleton(() => CreateReplyUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => DeleteReplyUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => LikeReplyUseCase(firebaseRepository: sl.call()));
sl.registerLazySingleton(() => ReadRepliesUseCase(firebaseRepository: sl.call()));



//Upload image to storage
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(firebaseRepository: sl.call()));


//Firebase
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() => FirebaseRemoteDataSourceImpl(firebaseAuth: sl.call(), firebaseFirestore: sl.call(), firebaseStorage: sl.call()));

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => firebaseFirestore);
  

}