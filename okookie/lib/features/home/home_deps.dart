import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/domain/cookie.dart';

class HomeDeps {
  static final bannerProvider =
      StateProvider<Future<Either<String, List<String>>>>(
    (ref) async {
      List<String> bannerImages = [];
      try {
        final ins = FirebaseFirestore.instance;
        final bannerImagesResponse = await ins.collection('banner').get();

        for (var element in bannerImagesResponse.docs) {
          bannerImages.add(element.data() as String);
        }
        return right(bannerImages);
      } catch (e) {
        print('ere $e');
        return left(e.toString());
      }
    },
  );

 static final featuredCookies = StateProvider<Future<Either<String, List<Cookie>>>>(
    (ref) async {
      List<Cookie> cookies = [];
      try {
        final ins = FirebaseFirestore.instance;
        final cookiesREsponse = await ins
            .collection('items')
          
            .get();

        for (var element in cookiesREsponse.docs) {
          cookies.add(Cookie.fromMap(element.data()));
        }
        print('featured $cookies');
        return right(cookies);
      } catch (e) {
        print('ere $e');
        return left(e.toString());
      }
    },
  );
}
