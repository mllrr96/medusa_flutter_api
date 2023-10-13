import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medusa_demo/product_list_screen.dart';
import 'package:medusa_flutter/medusa_flutter.dart';

late Medusa medusa;

void main() {
  medusa = Medusa(Config(baseUrl: 'http://localhost:9000'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff5f6aff)),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
                systemNavigationBarColor: Colors.white),
          )),
      home: const ProductListScreen(),
    );
  }
}
