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
        actions: const [],
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: AutoRouter(
          builder: (context, content) => content,
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
            EdgeInsets.symmetric(horizontal: 4, vertical: 0)),
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
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
        title: Row(
          children: [
            if (cookie.price?.value != null)
              Row(
                children: [
                  Text(
                    '${cookie.price?.value.toString()}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    cookie.price?.currency ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            SizedBox(
              width: 2,
            ),
            Text(
              '|',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              'stock: ${cookie.stock}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              width: 2,
            ),
          ],
        ),
        trailing: Consumer(builder: (context, ref, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.outlined(
                  onPressed: () {
                    if (cookie.id != null) {
                      loadingState.value = ref
                          .watch(
                              ControlPanelDeps.removeCookieProvider(cookie.id!))
                          .maybeMap(
                            orElse: () => false,
                            loading: (loading) => true,
                          );
                    }
                    // loadingState.value = removeProvide.maybeMap(
                    //   orElse: () => false,
                    //   loading: (loading) => true,
                    // );
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 16,
                    color: ref.read(appThemeProvider).colorScheme.error,
                  ),
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                      side: WidgetStatePropertyAll(BorderSide(
                          color: ref
                              .read(appThemeProvider)
                              .colorScheme
                              .error
                              .withOpacity(.5))),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: IconButton.outlined(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 16,
                    color: ref.read(appThemeProvider).colorScheme.onSurface,
                  ),
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                      side: WidgetStatePropertyAll(BorderSide(
                          color: ref
                              .read(appThemeProvider)
                              .colorScheme
                              .onSurface
                              .withOpacity(.5))),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          side: BorderSide(
                              color: ref
                                  .read(appThemeProvider)
                                  .colorScheme
                                  .onSurface),
                          borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
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
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [header, child],
        ),
      ),
    );
  }
}
