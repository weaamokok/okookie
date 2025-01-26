import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/helper_provider.dart';
import 'package:okookie/l10n/translations.g.dart';
import 'package:okookie/resources/resources.dart';

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
          title:const OTitle(),
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
              Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          Images.cookie,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Text('Cookie')
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        drawer: Drawer(
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
