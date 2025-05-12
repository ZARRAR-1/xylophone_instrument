import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({super.key});

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  final player = AudioPlayer();

  String? _userName = ''; // Initial username
  final TextEditingController _nameController = TextEditingController();

  Future<void> _checkFirstLaunch() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int isFirstLaunch =
        1; //flag to store if the app is launched for the first time or not

    if (isFirstLaunch == 1) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Your Xylophone Needs To Know Your Name'),
            content: TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Your Name'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  String enteredName = _nameController.text;
                  if (enteredName.isNotEmpty) {
                    setState(() {
                      _userName = enteredName;
                      isFirstLaunch = 0;
                    });
                    await prefs.setString('userName', enteredName);
                    await prefs.setBool('isFirstLaunch', false);
                  }
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Continue Without Name'),
                onPressed: () async {
                  //Setting 'My' as a first name if user do not enters his name on opening the app first time.
                  String enteredName = 'My';

                  setState(() {
                    _userName = enteredName;
                    isFirstLaunch = 0;
                  });
                    await prefs.setString('userName', enteredName);
                    await prefs.setBool('isFirstLaunch', false);

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Load username from shared preferences
      String? savedName = prefs.getString('userName');
      setState(() {
        _userName = savedName;
      });
    }
  }

  @override
 void initState()  {
    //Store the flag in the device so that whenever app is lauched, the flag isFirstLaunch is checked in initState()
    super.initState();
    unawaited(_checkFirstLaunch());
  }

  Future<void> playSound({required int soundNumber}) async {
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  Widget buildKey1({required soundNum, required bgColor}) {
    return InkWell(
      onTap: () async {
        await playSound(soundNumber: soundNum);
      },
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
                  child: _userName!.isNotEmpty
                      ? Text(
                          '$_userName\'s Xylophone',
                          style: GoogleFonts.pacifico(
                            shadows: [
                              const Shadow(
                                blurRadius:
                                    15.0, // Adjust blur radius as needed
                                color: Colors
                                    .grey, // Adjust shadow color as needed
                                offset: Offset(
                                    5.0, 5.0), // Adjust shadow offset as needed
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
                        )
                      : Text(
                          'My Xylophone',
                          style: GoogleFonts.pacifico(
                            shadows: [
                              const Shadow(
                                blurRadius:
                                    15.0, // Adjust blur radius as needed
                                color: Colors
                                    .grey, // Adjust shadow color as needed
                                offset: Offset(
                                    5.0, 5.0), // Adjust shadow offset as needed
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
