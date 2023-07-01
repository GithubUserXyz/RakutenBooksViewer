import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';
import 'package:rakuten_books_viewer/widgets/item_book.dart';
import 'package:rakuten_books_viewer/widgets/search_widget.dart';

import '../main_state.dart';

var logger = Logger();

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
                    child: _buildListView(context),
                    //child: _buildGridView(context),
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
        return ContainerBook(
            item: Provider.of<MainState>(context).listItems[index]);
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    List<Row> listItem = [];

    int maxNum = GetIt.I<MainState>().listItems.length >= 30
        ? 30
        : GetIt.I<MainState>().listItems.length;

    for (int i = 0; i < maxNum; i++) {
      if (i % 3 == 0) {
        logger.v("add Row");
        listItem.add(
          // ignore: prefer_const_constructors
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[],
          ),
        );
      }
      RakutenBooksItem item = Provider.of<MainState>(context).listItems[i];
      listItem[i ~/ 3].children.add(ContainerBook(
            item: item,
            width: MediaQuery.of(context).size.width / 3,
          ));
    }

    return ListView(
      shrinkWrap: true,
      children: listItem,
    );
  }
}
