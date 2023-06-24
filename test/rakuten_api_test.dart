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
    log.d("search books by title");
    var rakutenApi = RakutenApi();
    Response response = await rakutenApi.searchBooksByTitle("太陽");
    log.d(response.body);
    log.d("${response.statusCode}");
  });
}
