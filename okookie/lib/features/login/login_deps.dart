// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_deps.g.dart';
class LoginDeps {
  static final prefsProvider = Provider<Future<SharedPreferences>>((ref) async {
    return SharedPreferences.getInstance();
  });
  static final authProvider = StateProvider.autoDispose<Future<AuthStatus>>(
    (ref) async {
      final localStorage = await ref.read(prefsProvider);
      final localUserId = localStorage.getString('userId');
      final userId = FirebaseAuth.instance.currentUser?.uid;
      print('in local storage $localUserId');
      print('in local storage $userId');
      if (localUserId == userId) {
        print('should authenticate');
        ref.notifyListeners();
        return AuthStatus.authenticated;
      } else {
        return AuthStatus.unauthenticated;
      }
    },
  );

  static final loginProvider =
      FutureProvider.autoDispose.family<UserCredential, LoginRequest>(
    (ref, arg) async {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: arg.email, password: arg.password)
          .whenComplete(() => print('Login Success'));
      if (user.user != null) {
        final localStorage = await ref.read(prefsProvider);

        localStorage.setString('userId', user.user!.uid).whenComplete(
              () => print('di=o'),
            );
        ref.read(authProvider.notifier).state = Future.sync(
          () => AuthStatus.authenticated,
        );
      }
      return user;
    },
  );
}

@riverpod
Future<AuthStatus> authenticated(Ref ref) async {
  final localStorage = await SharedPreferences.getInstance();
  final localUserId = localStorage.getString('userId');
  final userId = FirebaseAuth.instance.currentUser?.uid;
  print('in local storage $localUserId');
  print('in local storage $userId');
  if (localUserId == userId) {
    print('should authenticate');
    ref.notifyListeners();
    return AuthStatus.authenticated;
  } else {
    return AuthStatus.unauthenticated;
  }
}

class LoginRequest extends Equatable {
  final String email;
  final String password;
  const LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  LoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

enum AuthStatus { authenticated, unauthenticated, unknown }
