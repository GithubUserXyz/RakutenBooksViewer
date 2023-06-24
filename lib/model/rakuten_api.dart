import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:rakuten_books_viewer/application_id.dart';

import '../main.dart';

class RakutenBooksItem {
  String title;
  String itemUrl;
  String largeImageUrl;

  RakutenBooksItem({
    required this.title,
    required this.itemUrl,
    required this.largeImageUrl,
  });

  factory RakutenBooksItem.fromJson(Map<String, dynamic> json) {
    return RakutenBooksItem(
        title: json["title"],
        itemUrl: json["itemUrl"],
        largeImageUrl: json["largeImageUrl"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["itemUrl"] = itemUrl;
    data["largeImageUrl"] = largeImageUrl;
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
}
