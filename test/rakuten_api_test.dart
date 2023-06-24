import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';

void main() {
  var log = Logger();
  setUp(() {
    Logger.level = Level.verbose;
  });
  test('search books by title', () async {
    List<RakutenBooksItem> listItems = [];
    log.d("search books by title");
    var rakutenApi = RakutenApi();
    Response response = await rakutenApi.searchBooksByTitle("太陽", listItems);
    //log.d(response.body);
    log.d("${response.statusCode}");
    Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
    log.d(res);
    log.d(res['count']);
    for (var value in res['Items']) {
      log.d(value['Item']['title']);

      listItems.add(RakutenBooksItem.fromJson(value['Item']));
    }
    log.d(listItems.toString());

    RakutenApiResponse apiResponse = RakutenApiResponse.fromJson(res);
    log.d(apiResponse.genreInformation);
    log.d(listItems[0].title);
  });
}
