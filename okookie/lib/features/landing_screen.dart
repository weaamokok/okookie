import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Okookie',
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
            
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue)),
              icon: Text('Order Now'),
              onPressed: () {},
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
