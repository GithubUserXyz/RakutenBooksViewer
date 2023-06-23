import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'router.dart' as router;

var log = Logger(level: Level.verbose);

class MainState extends ChangeNotifier {
  MainState();
}

void main() {
  Logger.level = Level.verbose;
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
