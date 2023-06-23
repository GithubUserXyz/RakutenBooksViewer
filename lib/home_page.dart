import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Hello'),
    );
  }
}
