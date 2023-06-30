import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/main_state.dart';

final logger = Logger();

class _SearchState extends ChangeNotifier {
  late TextEditingController _searchField;

  _SearchState() {
    _searchField = TextEditingController();
  }

  TextEditingController get searchField => _searchField;

  Future<void> search(String title) async {
    logger.v(title);
    await GetIt.I<MainState>().getItems(title);
    ChangeNotifier();
  }
}

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  late _SearchState _searchState;

  SearchWidget({super.key}) {
    _searchState = _SearchState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _searchState,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 70,
        width: MediaQuery.of(context).size.width - 70,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        //color: Colors.white,
        child: Form(
          key: _formKey,
          child: TextField(
            onSubmitted: (value) async {
              await _searchState.search(value);
            },
            controller: _searchState.searchField,
            decoration: const InputDecoration(hintText: 'here...'),
          ),
        ),
      ),
    );
  }
}
