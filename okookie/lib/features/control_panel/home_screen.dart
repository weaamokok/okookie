import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/app_router.gr.dart';
import 'package:okookie/domain/cookie.dart';
import 'package:okookie/features/control_panel/control_panel_deps.dart';
import 'package:okookie/features/control_panel/main_control_screen.dart';
import 'package:okookie/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                            context.router.push(const AddItemRoute());
                          }),
                    ),
                    child: FutureBuilder(
                        future: ref.watch(ControlPanelDeps.cookiesProvider),
                        builder: (
                          context,
                          snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Skeletonizer(
                              child: CookiesListing(
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
                                  return CookiesListing(
                                    cookies: cookies,
                                  );
                                }
                              },
                            );
                          }
                        })),
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
                          textAlign: TextAlign.center,
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
    );
  }
}

class CookiesListing extends StatelessWidget {
  const CookiesListing({super.key, required this.cookies});
  final List<Cookie> cookies;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView(
        children: cookies
            .map(
              (e) => OkookieCard(
                cookie: Cookie(
                    id: e.id,
                    name: e.name,
                    description: e.description,
                    ingredients: e.ingredients,
                    stock: e.stock,
                    price: e.price),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TextContainer extends ConsumerWidget {
  const TextContainer({
    super.key,
    required this.message,
  });
  final message;
  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13,
            color: ref.read(appThemeProvider).colorScheme.outline),
      ),
    );
  }
}
