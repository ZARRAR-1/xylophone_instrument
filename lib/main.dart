import 'package:flutter/material.dart';
import 'package:xylophone_instrument/xylophone.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();

  // return runApp(XylophoneApp());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const XylophoneApp(),
      //const SplashScreen(),
    );
  }
}