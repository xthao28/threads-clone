
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:threads_clone/features/domain/entities/thread/thread_entity.dart';
import 'package:threads_clone/features/domain/repository/firebase_repository.dart';
import 'package:threads_clone/features/domain/usecases/thread/create_thread_usecase.dart';

class MockFirebaseRepository extends Mock implements FirebaseRepository{}

void main() {
  late MockFirebaseRepository mockFirebaseRepository;
  late CreateThreadUseCase useCase;

  setUpAll(() {
    mockFirebaseRepository = MockFirebaseRepository();
    useCase = CreateThreadUseCase(firebaseRepository : mockFirebaseRepository);
  });  

  
  test('CreateThreadUseCase should call FirebaseRepository.createThread', () async { 
    final testCreateThread = ThreadEntity(
    createdAt: Timestamp.fromDate(DateTime(2023, 10, 12, 22, 51, 00)),
    creatorUid: '1234',
    userProfileUrl: 'hhhh',
    username: 'xthao',
    threadImageUrl: 'tttt',
    threadId: '4321',
    totalComments: 0,
    totalLikes: 0,
    likes: const [],    
    description: 'hiha',    
  );
    await useCase(testCreateThread);

    verify(mockFirebaseRepository.createThread(testCreateThread)).called(1);    
  });
}