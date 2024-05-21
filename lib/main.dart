import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 10));
  FlutterNativeSplash.remove();


  return runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  final player = AudioPlayer();

  XylophoneApp({super.key});

  Future<void> playSound({required int soundNumber}) async {
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  Expanded buildKey({required soundNum, required bgColor}) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: bgColor),
          onPressed: () async {
            playSound(soundNumber: soundNum);
          },
          child: const Text('')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showSemanticsDebugger: true, preventing sound
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(child: Text('My Xylophone',style: TextStyle(backgroundColor: Colors.black, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25))),
                buildKey(soundNum: 1, bgColor: Colors.red),
                buildKey(soundNum: 2, bgColor: Colors.orange),
                buildKey(soundNum: 3, bgColor: Colors.yellow),
                buildKey(soundNum: 4, bgColor: Colors.green),
                buildKey(soundNum: 5, bgColor: Colors.teal),
                buildKey(soundNum: 6, bgColor: Colors.lightBlue),
                buildKey(soundNum: 7, bgColor: Colors.purpleAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
