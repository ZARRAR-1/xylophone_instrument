import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class XylophoneApp extends StatelessWidget {
  final player = AudioPlayer();

  XylophoneApp({super.key});

  Future<void> playSound({required int soundNumber}) async {
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  Widget buildKey1({required soundNum, required bgColor}) {
    return Expanded(
      flex: 5,
      child: InkWell(
        onTap: () async {
          playSound(soundNumber: soundNum);
        },
        child: Container(
          child: Card.filled(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            color: bgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'My Xylophone',
                    style: GoogleFonts.pacifico(
                      shadows: [
                        const Shadow(
                          blurRadius: 15.0, // Adjust blur radius as needed
                          color: Colors.grey, // Adjust shadow color as needed
                          offset: Offset(5.0, 5.0), // Adjust shadow offset as needed
                        ),
                        // Add more Shadow objects for multiple shadows
                      ],
                      textStyle: const TextStyle(
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
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
                    child: buildKey1(
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
                    child: buildKey1(
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
                    child: buildKey1(soundNum: 5, bgColor: Colors.teal), //teal
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.75, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
                    // Add padding
                    child: buildKey1(soundNum: 4, bgColor: Colors.green),
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
                        buildKey1(soundNum: 3, bgColor: Colors.yellow), //yellow
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
                        buildKey1(soundNum: 2, bgColor: Colors.orange), //orange
                  ),
                ),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width * 0.45, // Adjust width
                  height: MediaQuery.of(context).size.height / 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                    // Add padding
                    child: buildKey1(soundNum: 1, bgColor: Colors.red), //red
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
