import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_state.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  final int gridItems = 15;

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MainState>(context).listItems.isEmpty) {
      return const Center(child: Text('リストが空です'));
    }
    return RefreshIndicator(
      onRefresh: () async {
        //Provider.of<MainState>(context).getItems("太陽");
      },
      child: GridView.builder(
        itemCount: gridItems,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.network(
              Provider.of<MainState>(context).listItems[index].largeImageUrl,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
