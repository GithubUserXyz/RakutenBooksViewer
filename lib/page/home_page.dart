import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/page/widgets/slide_show_widget.dart';

import '../main_state.dart';
import '../model/rakuten_api.dart';
import 'search_page.dart';

var logger = Logger();

// 画像をぼかすかどうか(trueでぼかし)
const _filterd = false;
// ImageFilterで使用される
const _sigmaX = 10.0;
const _sigmaY = 10.0;

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  static String routeName = '/';
  static String screenName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenName),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context.push('/${SearchPage.routeName}');
              },
              icon: const Icon(Icons.search))
        ],
      ),
      // スクロールビューでコンテンツを表示
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildContents(context),
        ),
      ),
    );
  }

  Widget _buildSearchPageLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          context.push('/${SearchPage.routeName}');
        },
        child: Text(SearchPage.screenName),
      ),
    );
  }

  List<Widget> _buildContents(BuildContext context) {
    // 一覧で表示する内容を返す
    List<Widget> contents = [];

    // スライドビュー
    // 一時的なアイテム
    List<SlideShowItem> _items = <SlideShowItem>[
      SlideShowItem(
        item: Container(color: Colors.green),
      ),
      SlideShowItem(
        item: Container(color: Colors.blue),
      ),
      SlideShowItem(
        item: Container(color: Colors.red),
      ),
    ];
    contents.add(SlideShowWidget(
      items: _items,
      height: 300,
      width: double.infinity,
    ));

    // タイトル
    contents.add(const Text('「太陽」の最新刊'));

    // 最新刊のリストビュー
    contents
        .add(ShowLatestBooks(widgetWidth: MediaQuery.of(context).size.width));

    return contents;
  }
}

// ignore: must_be_immutable
class ShowLatestBooks extends StatelessWidget {
  ShowLatestBooks({super.key, required this.widgetWidth}) {
    _maxRowNum = (widgetWidth ~/ 500) + 1;
  }

  // 最新の本の表示件数の最大値
  final int _latestMaxNum = 15;

  // Column(縦)の段数の最大値
  final int _maxColumnNum = 3;

  // Row(横)の列の最大値(ここの値で、画面に表示されている列数をかえる)
  late int _maxRowNum;

  // リストの最初と最後にいれる空白の幅
  final double _spaceWidth = 50;

  double widgetWidth;

  @override
  Widget build(BuildContext context) {
    logger.v('_buildBody');
    if (Provider.of<MainState>(context).latestItems.isEmpty) {
      return const Center(
        child: Text('リストはからです'),
      );
    }
    List<Column> latestItem = [];

    int maxNum = GetIt.I<MainState>().latestItems.length >= _latestMaxNum
        ? _latestMaxNum
        : GetIt.I<MainState>().latestItems.length;

    for (int i = 0; i < maxNum; i++) {
      if (i % _maxColumnNum == 0) {
        logger.v("add Row");
        latestItem.add(
          // ignore: prefer_const_constructors
          Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[],
          ),
        );
      }
      RakutenBooksItem item = Provider.of<MainState>(context).latestItems[i];
      latestItem[i ~/ _maxColumnNum].children.add(LatestCard(
            item: item,
            width: (MediaQuery.of(context).size.width - _spaceWidth * 2) /
                _maxRowNum,
          ));
    }

    // リストの最初と最後に空白をいれて、要素の位置を調整する
    // これをしないで、例えば、SingleChildScrollViewにおいて、Container
    // なかでpadding設定を行うとかすると、スクロール時に
    // なにもないところから突然要素が徐々にあらわれて、
    // なにもないところで突然要素が徐々にきえてみたいになった。
    // 最初へ追加
    latestItem.insert(0, Column(children: [SizedBox(width: _spaceWidth)]));
    // 最後へ追加
    latestItem.add(Column(children: [SizedBox(width: _spaceWidth)]));

    return SingleChildScrollView(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: ((MediaQuery.of(context).size.width - _spaceWidth * 2) /
                _maxRowNum) *
            LatestCard.ratio *
            _maxColumnNum,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: latestItem,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LatestCard extends StatelessWidget {
  late RakutenBooksItem item;

  // 角を丸くするときに使う値
  final double _radius = 15;

  // ボーダーのサイズ
  final double _borderSize = 1;

  // 横幅に対する縦の長さの倍
  static double ratio = 0.4;

  double width;
  late double height;
  late double paddingSize;

  LatestCard({super.key, required this.item, this.width = 300}) {
    height = width * ratio;
    paddingSize = width * 0.05;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingSize),
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
                  border: Border.all(
                    color: Colors.grey,
                    width: _borderSize,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_radius),
                  child: _buildBoxContent(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBoxContent(BuildContext context) {
    // paddingSizeを除いたの高さ(このコンテンツ領域の高さ)
    double contentHeight = height - paddingSize * 2 - _borderSize * 2;
    double contentWidth = width - paddingSize * 2 - _borderSize * 2;
    var content = Row(
      children: [
        Image.network(
          item.largeImageUrl,
          fit: BoxFit.cover,
          height: contentHeight,
          width: (contentHeight / sqrt(2)),
        ),
        Container(
          width: contentWidth - (contentHeight / sqrt(2)),
          height: contentHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Text(
                  item.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Text(
                  item.publisherName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // 最後にぼかしをいれる処理を確認して、行うばあいはぼかしをいれる
    return _filterd
        ? ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: _sigmaX,
              sigmaY: _sigmaY,
            ),
            child: content,
          )
        : content;
  }
}
