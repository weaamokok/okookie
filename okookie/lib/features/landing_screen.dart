import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/domain/cookie.dart';
import 'package:okookie/features/control_panel/control_panel_deps.dart';
import 'package:okookie/features/control_panel/home_screen.dart';
import 'package:okookie/features/home/home_deps.dart';
import 'package:okookie/helper_provider.dart';
import 'package:okookie/l10n/translations.g.dart';
import 'package:okookie/resources/resources.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../o_widgets/o_title.dart';

@RoutePage()
class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    // Get screen width
    final screenType = ref.read(
        HelperProvider.screenTypeProvider.call((context: context, size: null)));
    // Set button size based on screen width
    double buttonWidth;
    double coverImageHeight;
    if (screenType == ScreenType.phone) {
      // Small screen (phone)
      buttonWidth = 80;
      coverImageHeight = 200;
    } else if (screenType == ScreenType.tablet) {
      // Medium screen (tablet)
      buttonWidth = 110;
      coverImageHeight = 300;
    } else {
      // Large screen (laptop/desktop)
      buttonWidth = 120;
      coverImageHeight = 400;
    }
    final l10n = TranslationProvider.of(context).translations;
    return Scaffold(
        appBar: AppBar(
          title: const OTitle(),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8.0),
              child: IconButton(
                style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(buttonWidth, 40)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.secondary)),
                icon: AutoSizeText(
                  l10n.orderNow,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  minFontSize: 13,
                  maxFontSize: 30,
                ),
                onPressed: () {},
              ),
            ),
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                //TODO: fetch from server
                'https://hips.hearstapps.com/hmg-prod/images/chocolate-chip-cookies-index-641e16cc1424d.jpeg?crop=0.888888888888889xw:1xh;center,top&resize=1200:*',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,

                height: coverImageHeight,
              ),
              FutureBuilder(
                  future: ref.watch(HomeDeps.featuredCookies),
                  builder: (
                    context,
                    snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Skeletonizer(
                        child: HorizontalListing(
                          cookies: [Cookie.mock()],
                        ),
                      );
                    } else {
                      final cookiesResponse = snapshot.data;
                      if (cookiesResponse == null) {
                        return const TextContainer(
                          message: 'something went wrong',
                        );
                      }
                      return cookiesResponse.fold(
                        (l) => TextContainer(message: l),
                        (cookies) {
                          if (cookies.isEmpty) {
                            return const TextContainer(
                              message:
                                  'No cookies yet, add some let the people have fun!',
                            );
                          } else {
                            print('has data');
                            return HorizontalListing(
                              cookies: cookies,
                            );
                          }
                        },
                      );
                    }
                  })
            ],
          ),
        ),
        drawer: const Drawer(
          child: Column(
            children: [
              Row(
                children: [Text('home')],
              )
            ],
          ),
        ));
  }
}

class HorizontalListing extends StatelessWidget {
  const HorizontalListing({required this.cookies, super.key});
  final List<Cookie> cookies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: ListView.builder(
        itemCount: cookies.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          print('-image${cookies[index].name}');
          final images = cookies[index].images ?? [];

          Container(
            height: 200,
            width: 200,
            child: Column(
              children: [
                if (images.isNotEmpty)
                  Image.memory(
                    base64Decode(
                      cookies[index].images?.first ?? '',
                    ),
                    errorBuilder: (context, error, stackTrace) => Text('error'),
                  ),
                Text('cookies[index].name ?? ' ''),
                // Text(cookies[index].name ?? ''),
                // Text(cookies[index].price?.value.toString() ?? '')
              ],
            ),
          );
        },
      ),
    );
  }
}
