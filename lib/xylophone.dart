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

    //If isFirstLaunch return nulls, it defaults to true:
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch == true) {
      if (context.mounted) {
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
                        _userName = '$enteredName\'s';
                        isFirstLaunch = false;
                      });
                      await prefs.setString('userName', enteredName);
                      await prefs.setBool('isFirstLaunch', false);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                TextButton(
                  child: const Text('Continue Without Name'),
                  onPressed: () async {
                    //Setting 'My' as a first name if user do not enters his name on opening the app first time.
                    String enteredName = 'My';

                    setState(() {
                      _userName = enteredName;
                      isFirstLaunch = false;
                    });
                    await prefs.setString('userName', enteredName);
                    await prefs.setBool('isFirstLaunch', false);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      // Load username from shared preferences
      String? savedName = prefs.getString('userName');
      setState(() {
        _userName = savedName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    unawaited(_checkFirstLaunch());
  }

  Future<void> playSound({required int soundNumber}) async {
    await player.play(AssetSource('note$soundNumber.wav'));
  }

  Widget buildKey({required soundNum, required bgColor}) {
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

  Widget buildKeyPad(
      {required int soundNum,
      required double widthFactor,
      required Color color}) {
    return SizedBox(
      width: widthFactor * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 0.5),
        child: buildKey(soundNum: soundNum, bgColor: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: _userName!.isNotEmpty
                              ? Semantics(
                                  label: 'Title of the Xylophone App',
                                  enabled: true,
                                  readOnly: true,
                                  child: Text(
                                    '$_userName Xylophone',
                                    style: GoogleFonts.pacifico(
                                      shadows: [
                                        const Shadow(
                                          blurRadius: 15.0,
                                          color: Colors.grey,
                                          offset: Offset(5.0, 5.0),
                                        ),
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
                                )
                              : Text(
                                  'My Xylophone',
                                  style: GoogleFonts.pacifico(
                                    shadows: [
                                      const Shadow(
                                        blurRadius: 15.0,
                                        color: Colors.grey,
                                        offset: Offset(5.0, 5.0),
                                      ),
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
                        Semantics(
                          label: 'Purple Colored Key',
                          enabled: true,
                          readOnly: true,
                          child: buildKeyPad(
                              soundNum: 7,
                              widthFactor: 1.0,
                              color: Colors.purpleAccent),
                        ),
                        Semantics(
                          enabled: true,
                          label: 'Blue Colored Key',
                          readOnly: true,
                          child: buildKeyPad(
                              soundNum: 6,
                              widthFactor: 0.95,
                              color: Colors.lightBlue),
                        ),
                        Semantics(
                          readOnly: true,
                          label: 'Teal Colored Key',
                          enabled: true,
                          child: buildKeyPad(
                              soundNum: 5,
                              widthFactor: 0.85,
                              color: Colors.teal),
                        ),
                        Semantics(
                          readOnly: true,
                          label: 'Green Colored Key',
                          enabled: true,
                          child: buildKeyPad(
                              soundNum: 4,
                              widthFactor: 0.75,
                              color: Colors.green),
                        ),
                        Semantics(
                          readOnly: true,
                          label: 'Yellow Colored Key',
                          enabled: true,
                          child: buildKeyPad(
                              soundNum: 3,
                              widthFactor: 0.65,
                              color: Colors.yellow),
                        ),
                        Semantics(
                          readOnly: true,
                          label: 'Orange Colored Key',
                          enabled: true,
                          child: buildKeyPad(
                              soundNum: 2,
                              widthFactor: 0.55,
                              color: Colors.orange),
                        ),
                        Semantics(
                          readOnly: true,
                          label: 'Red Colored Key',
                          enabled: true,
                          child: buildKeyPad(
                              soundNum: 1, widthFactor: 0.45, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
