import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:rakuten_books_viewer/application_id.dart';

import '../main.dart';

String _columnTitle = 'title';
String _columnItemUrl = 'itemUrl';
String _columnLargeImageUrl = 'largeImageUrl';
String _columnAuthor = 'author';
String _columnPublisherName = 'publisherName';

class RakutenBooksItem {
  String title;
  String itemUrl;
  String largeImageUrl;
  String author;
  String publisherName;

  RakutenBooksItem({
    required this.title,
    required this.itemUrl,
    required this.largeImageUrl,
    required this.author,
    required this.publisherName,
  });

  factory RakutenBooksItem.fromJson(Map<String, dynamic> json) {
    return RakutenBooksItem(
        title: json[_columnTitle],
        itemUrl: json[_columnItemUrl],
        largeImageUrl: json[_columnLargeImageUrl],
        author: json[_columnAuthor],
        publisherName: json[_columnPublisherName]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[_columnTitle] = title;
    data[_columnItemUrl] = itemUrl;
    data[_columnLargeImageUrl] = largeImageUrl;
    data[_columnAuthor] = author;
    data[_columnPublisherName] = publisherName;
    return data;
  }
}

class RakutenApiResponse {
  List<dynamic> genreInformation;

  RakutenApiResponse({required this.genreInformation});

  factory RakutenApiResponse.fromJson(Map<String, dynamic> json) {
    return RakutenApiResponse(genreInformation: json["GenreInformation"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["GenreInformation"] = genreInformation;
    return data;
  }
}

class RakutenApi {
  Future<Response> searchBooksByTitle(
      String title, List<RakutenBooksItem> listItems) async {
    var url = Uri.https(
        "app.rakuten.co.jp",
        "/services/api/BooksBook/Search/20170404",
        {'applicationId': applicationId, 'title': title});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      //log.d(response.body);
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      for (var json in res["Items"]) {
        listItems.add(RakutenBooksItem.fromJson(json["Item"]));
      }
    } else {
      log.d('erro ${{response.statusCode}}');
    }
    return response;
  }

  Future<Response> searchBooksByTitleOrderByReleaseDate(
      String title, bool orderFlag, List<RakutenBooksItem> listItems) async {
    // 並び順が新しいもの順か古いもの順かを格納する変数
    String _sort;
    // trueの場合は新しいもの順
    if (orderFlag == true) {
      _sort = '-releaseDate';
    }
    // それ以外(false)の場合は古いもの順
    else {
      _sort = '+releaseDate';
    }
    var url = Uri.https(
        "app.rakuten.co.jp",
        "/services/api/BooksBook/Search/20170404",
        {'applicationId': applicationId, 'title': title, 'sort': _sort});
    var response = await http.get(url);

    if (response.statusCode == 200) {
      //log.d(response.body);
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      for (var json in res["Items"]) {
        listItems.add(RakutenBooksItem.fromJson(json["Item"]));
      }
    } else {
      log.d('erro ${{response.statusCode}}');
    }
    return response;
  }
}
