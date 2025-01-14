import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginDeps {
  static final loginProvider =
      FutureProvider.family<UserCredential?, LoginRequest>(
    (ref, arg) async {
      final firebaseAuth = FirebaseAuth.instance;
      try {
        return await firebaseAuth.signInWithEmailAndPassword(
            email: arg.email, password: arg.password);
      } catch (e) {
        print('error: $e');
        return null;
      }
    },
  );
}

class LoginRequest {
  final String email;
  final String password;
  LoginRequest({required this.email, required this.password});
}
