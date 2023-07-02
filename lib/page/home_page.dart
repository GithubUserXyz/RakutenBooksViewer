import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import 'search_page.dart';

var logger = Logger();

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: _buildBody(context),
      body: _buildSearchPageLink(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Text('');
  }

  Widget _buildSearchPageLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.push('/${SearchPage.routeName}');
        },
        child: Text(screenName),
      ),
    );
  }
}
