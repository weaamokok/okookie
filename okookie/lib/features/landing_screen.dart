import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:okookie/l10n/translations.g.dart';
import 'package:okookie/resources/resources.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Set button size based on screen width
    double buttonWidth;
    if (screenWidth < 600) {
      // Small screen (phone)
      buttonWidth = 80;
    } else if (screenWidth < 1024) {
      // Medium screen (tablet)
      buttonWidth = 110;
    } else {
      // Large screen (laptop/desktop)
      buttonWidth = 120;
    }
    final l10n = TranslationProvider.of(context).translations;
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(
            'Okookie',
            maxFontSize: 50,
            minFontSize: 20,
            style: TextStyle(
                fontFamily: 'mataryah', color: Colors.black, fontSize: 50),
          ),
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                'https://hips.hearstapps.com/hmg-prod/images/chocolate-chip-cookies-index-641e16cc1424d.jpeg?crop=0.888888888888889xw:1xh;center,top&resize=1200:*',
                width: double.infinity,
                height: 300,
              ),
              Row(
                children: [
                  Container(
                    width: 250, //make them dynamicF
                    height: 200,
                    child: Column(
                      children: [Image.asset(Images.cookie)],
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
