import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/domain/cookie.dart';

class ControlPanelDeps {
  static final fetchCookieProvider =
      StateNotifierProvider<CookiesNotifier, List<Cookie>?>(
    (ref) {
      return CookiesNotifier()..fetchCookies();
    },
  );
  static final cookiesProvider =
      StateProvider<Future<Either<String, List<Cookie>>>>(
    (ref) async {
      List<Cookie> cookies = [];
      try {
        final ins = FirebaseFirestore.instance;
        final cookiesREsponse = await ins.collection('items').get();

        for (var element in cookiesREsponse.docs) {
          cookies.add(Cookie.fromMap(element.data()));
        }
        return right(cookies);
      } catch (e) {
        print('error $e');
        return left(e.toString());
      }
    },
  );
  static final addCookieProvider = FutureProvider.family<void, Cookie>(
      (ref, arg) async => await CookiesNotifier().addCookie(arg));

  static final removeCookieProvider =
      FutureProvider.family<void, String>((ref, arg) async {
    final ins = FirebaseFirestore.instance;

    try {
      final docToBeRemoved =
          await ins.collection('items').where('id', isEqualTo: arg).get();
      await ins.collection('items').doc(docToBeRemoved.docs.first.id).delete();
      ref.refresh(fetchCookieProvider);
      // state = [
      //   if (state != null)
      //     for (final todo in state!)
      //       if (todo.id != todoId) todo,
      // ];
    } catch (error) {}
  });
  //=> await CookiesNotifier().removeCookie(arg));
}

class CookiesNotifier extends StateNotifier<List<Cookie>?> {
  // We initialize the list of todos to an empty list
  CookiesNotifier() : super([]);

  // Let's allow the UI to add todos.
  Future<bool> addCookie(Cookie item) async {
    final ins = FirebaseFirestore.instance;
    try {
      await ins.collection('items').add(item.toMap());

      // Since our state is immutable, we are not allowed to do `state.add(todo)`.
      // Instead, we should create a new list of todos which contains the previous
      // items and the new one.
      // Using Dart's spread operator here is helpful!
      state = [...?state, item];

      return true;
      // No need to call "notifyListeners" or anything similar. Calling "state ="
      // will automatically rebuild the UI when necessary.
    } catch (error) {
      return false;
    }
  }

  Future<List<Cookie>> fetchCookies() async {
    final ins = FirebaseFirestore.instance;
    final cookiesREsponse = await ins.collection('items').get();

    List<Cookie> cookies = [];

    for (var element in cookiesREsponse.docs) {
      cookies.add(Cookie.fromMap(element.data()));
    }
    state = cookies;
    return cookies;
  }

  // Let's allow removing todos
  Future<bool> removeCookie(String todoId) async {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    final ins = FirebaseFirestore.instance;

    try {
      final docToBeRemoved =
          await ins.collection('items').where('id', isEqualTo: todoId).get();
      await ins.collection('items').doc(docToBeRemoved.docs.first.id).delete();
      fetchCookies();
      state = [
        if (state != null)
          for (final todo in state!)
            if (todo.id != todoId) todo,
      ];
      return true;
    } catch (error) {
      return false;
    }
  }
}
