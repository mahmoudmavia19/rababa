import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {

  late FirebaseAuth auth;

  setUp(() {
    auth = MockFirebaseAuth();
   });

  test('Test sign-in with email and password', () async {
     const email = 'student@gmail.com';
    const password = '123456';
    final expectedUser = MockUserCredential();

     when(() => auth.signInWithEmailAndPassword(email: 'student@gmail.com', password: '123456'))
        .thenAnswer((invocation)  {
     return Future.value(expectedUser);
        });

    final user = await auth.signInWithEmailAndPassword(email: email , password: password);

     expect(user, expectedUser);
    verify(() => auth.signInWithEmailAndPassword(email: email, password: password)).called(1);
  });

  test('logout test ', ()async{
    when(()=>auth.signOut()).thenAnswer((_)=>Future<void>.delayed(const Duration(seconds: 1))) ;
    Future<void> au = auth.signOut() ;

  });
}
