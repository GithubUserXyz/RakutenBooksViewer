import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:rakuten_books_viewer/application_id.dart';

import '../main.dart';

class RakutenApi {
  Future<Response> searchBooksByTitle(String title) async {
    var url = Uri.https(
        "app.rakuten.co.jp",
        "/services/api/BooksBook/Search/20170404",
        {'applicationId': applicationId, 'title': title});
    var response = await http.get(url);
    return response;
    if (response.statusCode == 200) {
      log.d(response.body);
    } else {
      log.d('erro ${{response.statusCode}}');
    }
  }
}
