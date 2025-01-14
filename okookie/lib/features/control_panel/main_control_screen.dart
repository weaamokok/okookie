import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainControlScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Control Screen'),
      ),
      body: Center(
        child: Text('Main Control Screen'),
      ),
    );
  }
}
