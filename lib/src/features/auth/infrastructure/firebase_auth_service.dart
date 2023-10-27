import 'package:firebase_auth/firebase_auth.dart';
import 'package:threads/src/features/auth/domain/user_auth_credentials_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  Future<UserCredential> signUp(
      {required UserAuthCredential credential}) async {
    return await _auth.createUserWithEmailAndPassword(
        email: credential.email, password: credential.password);
  }

  Future<UserCredential> signIn(
      {required UserAuthCredential credential}) async {
    return await _auth.signInWithEmailAndPassword(
        email: credential.email, password: credential.password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
