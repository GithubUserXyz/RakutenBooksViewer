import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';

class MainState extends ChangeNotifier {
  final List<RakutenBooksItem> _listItems = [];
  List<RakutenBooksItem> get listItems => _listItems;

  MainState();

  Future<void> getItems(String title) async {
    await GetIt.I<RakutenApi>().searchBooksByTitle(title, _listItems);
    notifyListeners();
  }
}
