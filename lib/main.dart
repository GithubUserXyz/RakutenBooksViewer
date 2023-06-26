import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rakuten_books_viewer/model/rakuten_api.dart';
import 'main_state.dart';
import 'router.dart' as router;

var log = Logger(level: Level.verbose);

void main() {
  // ログレベルの設定
  Logger.level = Level.verbose;

  // Repository,API
  GetIt.instance.registerLazySingleton(() => RakutenApi());

  // Appの実行
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainState>(create: (context) => MainState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<MainState>(context).getItems("太陽");
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
