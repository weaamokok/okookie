import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:okookie/app_router.gr.dart';
import 'package:okookie/features/login/login_deps.dart';
import 'package:okookie/helper_provider.dart';
import 'package:okookie/l10n/translations.g.dart';
import 'package:okookie/resources/resources.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with WidgetsBindingObserver {
  late Size _lastSize;
  ScreenType? screenType;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // [View.of] exposes the view from `WidgetsBinding.instance.platformDispatcher.views`
    // into which this widget is drawn.
    _lastSize = View.of(context).physicalSize;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      print('didChangeMetrics');
      _lastSize = View.of(context).physicalSize;
      HelperProvider.screenTypeProvider
          .call((context: context, size: _lastSize));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, widget) {
        ref.watch(LoginDeps.authProvider);
        ref.listen(LoginDeps.authProvider, (previous, next) async {
          final state = await next;
          print(' listenenit > $state');
          print(' listenenit > $state');
          if (state == AuthStatus.authenticated) {
            context.router.navigate(const MainControlRoute());
          }
        });
        screenType = ref.watch(HelperProvider.screenTypeProvider
            .call((context: context, size: _lastSize)));

        final formPadding = switch (screenType) {
          ScreenType.phone => const EdgeInsetsDirectional.all(20.0),
          ScreenType.tablet => const EdgeInsetsDirectional.all(50.0),
          ScreenType.laptop => const EdgeInsetsDirectional.all(150.0),
          null => const EdgeInsetsDirectional.only(start: 25.0, end: 10),
        };
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (screenType != ScreenType.phone)
                const Expanded(child: SideDecoration()),
              Expanded(
                  child: LoginForm(
                formPadding: formPadding,
              ))
            ]);
      }),
    );
  }
}

// ignore: must_be_immutable
class LoginForm extends HookConsumerWidget {
  LoginForm({super.key, this.formPadding});
  EdgeInsetsDirectional? formPadding;
  @override
  Widget build(BuildContext context, ref) {
  final isLoading = useState(false);

    final l10n = TranslationProvider.of(context).translations;
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    void process() async {
      try {
        final userResponse = ref.watch(LoginDeps.loginProvider(
          LoginRequest(
              email: userNameController.text,
              password: passwordController.text),
        ));
        print('userResponse: $userResponse');
        userResponse.when(data: (data) {
          // print('data: $data');
          isLoading.value = false;
          context.router.maybePop();
          return context.router.navigate(const MainControlRoute());
        }, loading: () {
          print('loading');

          return isLoading.value = true;
        }, error: (error, stackTrace) {
          isLoading.value = false;
          final exception = error as FirebaseException;
          return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(exception.message ?? l10n.core.somthingWentWrong),
            ),
          );
        });
      } catch (e) {
        print('error: $e');
      }
    }

    ;
    return Form(
      child: Padding(
        padding: formPadding ?? const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0),
              child: Text(
                l10n.loginTitle,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: userNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return l10n.userNameValidation;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: l10n.userNameFieldHint,
                hintStyle: TextStyle(
                    color: Colors.black87.withOpacity(.5), fontSize: 13),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black87.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), gapPadding: 10),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              onFieldSubmitted: (value) => process(),
              validator: (value) {
                if (value!.isEmpty) {
                  return l10n.passwordValidation;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: l10n.passwordFieldHint,
                hintStyle: TextStyle(
                    color: Colors.black87.withOpacity(.5), fontSize: 13),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black87.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 10),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer(builder: (context, ref, widget) {
              return SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: process,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.secondary)),
                    child: isLoading.value
                        ? const CircularProgressIndicator.adaptive()
                        : Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black87.withOpacity(.5)),
                          ),
                  ));
            })
          ],
        ),
      ),
    );
  }
}

class SideDecoration extends ConsumerWidget {
  const SideDecoration({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final screenType = ref.read(
        HelperProvider.screenTypeProvider.call((context: context, size: null)));
    final l10n = TranslationProvider.of(context).translations;

    return Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              Images.loginBg,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.7),
                        Colors.grey.withOpacity(0.0),
                      ],
                      stops: const [
                        0.1,
                        0.5,
                        0.7,
                        1.0
                      ])),
            )
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Let's Cookie Again!",
                style: TextStyle(
                  fontFamily: 'mataryah',
                  color: Colors.white,
                  fontSize: screenType == ScreenType.phone
                      ? 30
                      : screenType == ScreenType.tablet
                          ? 40
                          : 70,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15.0),
                child: Text(l10n.loginSubtitle,
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
