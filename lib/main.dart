import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  return runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  final player = AudioPlayer();

  XylophoneApp({super.key});

  Future<void> playSound({required int soundNumber}) async {
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  Widget buildKey({required soundNum, required bgColor}) {
    return Expanded(
      flex: 5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bgColor),
        onPressed: () async {
          playSound(soundNumber: soundNum);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              shape: CircleBorder(),
              color: Colors.white,
            ),
            // SizedBox(
            //   width: 100,
            // ),
            Card(
              shape: CircleBorder(),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Center(
                  child: Text(
                    'My Xylophone',
                    style: TextStyle(
                      backgroundColor: Colors.black,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 1.0, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0.5),
                    // Add padding
                    child: buildKey(
                        soundNum: 7,
                        bgColor: Colors.purpleAccent), //purpleAccent
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.95, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child: buildKey(
                        soundNum: 6, bgColor: Colors.lightBlue), //lightBlue
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.85, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child: buildKey(soundNum: 5, bgColor: Colors.teal), //teal
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.75, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child: buildKey(soundNum: 4, bgColor: Colors.green),
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.65, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child:
                        buildKey(soundNum: 3, bgColor: Colors.yellow), //yellow
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.55, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child:
                        buildKey(soundNum: 2, bgColor: Colors.orange), //orange
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.45, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                    // Add padding
                    child: buildKey(soundNum: 1, bgColor: Colors.red), //red
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
