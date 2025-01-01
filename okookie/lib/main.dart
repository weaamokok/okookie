import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:okookie/features/landing_screen.dart';
import 'package:okookie/l10n/translations.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xff446A46),
          secondary: Color(0xffE7CCCC),
          surface: Color(0xffFDFDF6),
          error: Color.fromARGB(255, 224, 33, 33),
          onPrimary: Color.fromARGB(255, 32, 29, 29),
          onSecondary: Color(0xffE7CCCC),
          onSurface: Color(0xff282828),
          onError: Color.fromARGB(255, 255, 238, 238),
          brightness: Brightness.light,
        ),

        // primarySwatch: const MaterialColor(0xffE7CCCC, {}),
      ),
      home: const LandingScreen(),
    );
  }
}
