import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'main_state.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  final int gridItems = 30;

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //if (GetIt.I<MainState>().listItems.isEmpty) {
    if (Provider.of<MainState>(context).listItems.isEmpty) {
      return const Center(child: Text('リストが空です'));
    }
    return RefreshIndicator(
      onRefresh: () async {
        await GetIt.I<MainState>().getItems("太陽");
      },
      //child: _buildSearchBar(context),
      //child: _buildGridView(context),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            // 本の一覧
            SingleChildScrollView(
              child: _buildGridView(context),
            ),
            // 検索
            Positioned.fill(
              top: 14,
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildSearchBar(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: gridItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.network(
            Provider.of<MainState>(context).listItems[index].largeImageUrl,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 70,
      width: MediaQuery.of(context).size.width - 70,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      //color: Colors.white,
      child: const TextField(),
    );
  }
}
