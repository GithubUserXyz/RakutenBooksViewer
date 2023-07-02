import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';
import 'main_state.dart';
import 'router.dart' as router;

var log = Logger(level: Level.verbose);

void main() async {
  // ログレベルの設定
  Logger.level = Level.verbose;

  // Repository,API
  GetIt.instance.registerLazySingleton(() => RakutenApi());

  // MainState
  GetIt.instance.registerLazySingleton(() => MainState());

  // 初期化
  await GetIt.I<MainState>().getItemsOrderByReleaseDate("太陽", true);

  // Appの実行
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainState>.value(value: GetIt.I<MainState>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router.route,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
