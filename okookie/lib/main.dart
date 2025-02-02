import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/app_router.dart';
import 'package:okookie/firebase_options.dart';
import 'package:okookie/l10n/translations.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Ideal time to initialize
  runApp(ProviderScope(child: TranslationProvider(child: const MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final appRouter = AppRouter(ref);
    return MaterialApp.router(
        routerConfig: appRouter.config(),
        locale: TranslationProvider.of(context).flutterLocale, // use provider
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: ref.read(appThemeProvider));
  }
}

final appThemeProvider = Provider(
  (ref) => ThemeData(
      colorScheme: ColorScheme(
        primary: const Color(0xff446A46),
        secondary: const Color.fromARGB(255, 235, 182, 182),
        onSecondaryContainer: Color.fromARGB(255, 60, 63, 63),
        surface: const Color(0xffFDFDF6),
        outlineVariant: const Color.fromARGB(255, 186, 186, 186),
        onSurfaceVariant: Colors.black87.withOpacity(.2),
        error: const Color.fromARGB(255, 225, 61, 61).withOpacity(.9),
        onPrimary: const Color.fromARGB(255, 32, 29, 29),
        onSecondary: Color.fromARGB(255, 29, 26, 26),
        outline: const Color.fromARGB(255, 139, 139, 139),
        onSurface: Color(0xff282828),
        onError: const Color.fromARGB(255, 255, 238, 238),
        brightness: Brightness.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        fillColor: const Color.fromARGB(182, 249, 246, 246),
        hintStyle:
            TextStyle(color: Colors.black87.withOpacity(.5), fontSize: 13),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87.withOpacity(.2)),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 10),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffE7CCCC)),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 10),
      )
      // primarySwatch: const MaterialColor(0xffE7CCCC, {}),
      ),
);
