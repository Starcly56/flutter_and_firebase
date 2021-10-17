import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/services/database.dart';

class AuthService {
  //_ means private
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GetUser? _userFromFirebaseUser(User? user) {
    return user != null ? GetUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<GetUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString() + 'error');
      return null;
    }
  }

  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future register(String email, String password) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      // store user information in the database
      await DatabaseService(uid: user!.uid).updateUserData('Seize the day','5', 'Ujjwal Humagain' , 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // logout
  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
