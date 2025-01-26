import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:okookie/app_router.gr.dart';
import 'package:okookie/domain/cookie.dart';
import 'package:okookie/features/control_panel/control_panel_deps.dart';
import 'package:okookie/main.dart';

import '../../o_widgets/o_title.dart';

@RoutePage()
class MainControlScreen extends ConsumerWidget {
  const MainControlScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const OTitle(),
        actions: [],
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  OSection(
                      header: SectionHeader(
                        title: 'manage cookies',
                        action: OButton(
                            backgroundColor: const Color(0xff282828),
                            text: 'add cookie',
                            action: () {
                              context.router.navigate(const AddItemRoute());
                              ref.read(ControlPanelDeps.addCookieProvider.call(
                                  Cookie(
                                      id: '11111',
                                      name: 'red vilvid ',
                                      description: 'jkjkjkj',
                                      price: 98,
                                      stock: 3,
                                      originalPrice: 100)));
                            }),
                      ),
            
                        child:Consumer(builder: (context, ref, child) {
    var cookies = ref.watch(await ControlPanelDeps.cookiesProvider);
                  return    SizedBox(
                              height: 240,
                              child: ListView(
                                children: cookies.
                                    ? cookies
                                        .map(
                                          (e) => OkookieCard(
                                            cookie: Cookie(
                                                id: e.id,
                                                name: e.name,
                                                description: e.description,
                                                ingredients: e.ingredients,
                                                originalPrice: e.originalPrice,
                                                price: e.price),
                                          ),
                                        )
                                        .toList()
                                    : [],
                              ),
                            )
                          : Container(
                              child: Text('empty');
                          )
                      } )),
                  OSection(
                      header: const SectionHeader(
                        title: 'manage orders',
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView(
                          children: [
                            OkookieCard(
                              cookie: Cookie(id: 'jhj'),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Expanded(
                child: OSection(
                    header: const SectionHeader(
                      title: 'background Image',
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "upload new banner image for the website",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            "1500x850 is the prefered ratio",
                            style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xff282828).withOpacity(.5)),
                          ),
                          const SizedBox(height: 10),
                          OButton(text: 'pick photo', action: () {})
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, this.action, required this.title});
  final Widget? action;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        if (action != null)
          Align(alignment: AlignmentDirectional.centerEnd, child: action),
      ],
    );
  }
}

class OButton extends HookConsumerWidget {
  const OButton(
      {this.backgroundColor,
      this.foregroundColor,
      this.loadingState,
      required this.text,
      required this.action,
      super.key});
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ValueNotifier? loadingState;
  final String text;
  final Function() action;
  @override
  Widget build(BuildContext context, ref) {
    bool isLoading = loadingState?.value ?? false;
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(backgroundColor ??
            ref.read(appThemeProvider).colorScheme.onSurface),
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)))),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                    ref.read(appThemeProvider).colorScheme.surface),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                  fontSize: 12, color: foregroundColor ?? Colors.white),
            ),
    );
  }
}

class OkookieCard extends HookWidget {
  const OkookieCard({super.key, required this.cookie});
  final Cookie cookie;
  @override
  Widget build(
    BuildContext context,
  ) {
    final loadingState = useState(false);

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          shape: BoxShape.rectangle),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Text(
          cookie.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        ),
        trailing: Consumer(builder: (context, ref, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OButton(
                action: () {
                  loadingState.value = ref
                      .watch(ControlPanelDeps.removeCookieProvider(cookie.id))
                      .maybeMap(
                        orElse: () => false,
                        loading: (loading) => true,
                      );
                  // loadingState.value = removeProvide.maybeMap(
                  //   orElse: () => false,
                  //   loading: (loading) => true,
                  // );
                },
                text: 'delete',
                loadingState: loadingState,
                backgroundColor:
                    ref.read(appThemeProvider).colorScheme.errorContainer,
              ),
              const SizedBox(
                width: 5,
              ),
              OButton(action: () {}, text: 'edit')
            ],
          );
        }),
      ),
    );
  }
}

class OSection extends StatelessWidget {
  const OSection({super.key, required this.header, required this.child});
  final SectionHeader header;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xff282828).withOpacity(.03),
      borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20.0, vertical: 10),
        child: Column(
          children: [header, child],
        ),
      ),
    );
  }
}
