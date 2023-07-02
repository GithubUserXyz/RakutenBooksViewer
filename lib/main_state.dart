import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';

final logger = Logger();

class MainState extends ChangeNotifier {
  List<RakutenBooksItem> _listItems = [];
  List<RakutenBooksItem> get listItems => _listItems;

  MainState();

  Future<void> getItems(String title) async {
    logger.v(title);
    _listItems = [];
    await GetIt.I<RakutenApi>().searchBooksByTitle(title, _listItems);
    notifyListeners();
    /*
    for (RakutenBooksItem item in _listItems) {
      logger.v(item.title);
    }*/
    logger.v(_listItems.length.toString());
  }

  Future<void> getItemsOrderByReleaseDate(String title, bool orderFlag) async {
    logger.v(title);
    _listItems = [];
    await GetIt.I<RakutenApi>()
        .searchBooksByTitleOrderByReleaseDate(title, orderFlag, _listItems);
    notifyListeners();
    /*
    for (RakutenBooksItem item in _listItems) {
      logger.v(item.title);
    }*/
    logger.v(_listItems.length.toString());
  }
}
