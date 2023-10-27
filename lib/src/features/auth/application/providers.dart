import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/src/features/auth/domain/user_auth_credentials_model.dart';
import 'package:threads/src/features/auth/infrastructure/firebase_auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authService =
    Provider((ref) => FirebaseAuthService(ref.read(firebaseAuthProvider)));

final userProvider = Provider<User?>((ref) {
  return FirebaseAuthService(ref.read(firebaseAuthProvider)).currentUser();
});

final signUpProvider =
    FutureProvider.family<UserCredential, UserAuthCredential>(
        (ref, credential) async {
  return ref.read(authService).signUp(credential: credential);
});

final signOutProvider = FutureProvider<void>((ref) async {
  return ref.read(authService).signOut();
});

final signInProvider =
    FutureProvider.family<UserCredential, UserAuthCredential>(
        (ref, credential) async {
  return ref.read(authService).signIn(credential: credential);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authService).authStateChanges();
});
