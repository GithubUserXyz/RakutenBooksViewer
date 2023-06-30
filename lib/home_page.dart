import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/widgets/search_widget.dart';

import 'main_state.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    /*
    //if (GetIt.I<MainState>().listItems.isEmpty) {
    if (Provider.of<MainState>(context).listItems.isEmpty) {
      return const Center(
        child: Text('リストが空です'),
      );
    }*/
    return RefreshIndicator(
      onRefresh: () async {},
      //child: _buildSearchBar(context),
      //child: _buildGridView(context),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Provider.of<MainState>(context).listItems.isEmpty
                ?
                // 空の場合
                const Center(child: Text('リストは空です'))
                :
                // 本の一覧
                SingleChildScrollView(
                    child: _buildGridView(context),
                  ),
            // 検索
            Positioned.fill(
              top: 14,
              child: Align(
                alignment: Alignment.topCenter,
                child: SearchWidget(),
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
      itemCount: GetIt.I<MainState>().listItems.length >= 30
          ? 30
          : GetIt.I<MainState>().listItems.length,
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
}
