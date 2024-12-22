import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({super.key});

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  String _userName = 'My'; // Initial username
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Your Name'),
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
                    });
                    await prefs.setString('userName', enteredName);
                    await prefs.setBool('isFirstLaunch', false);
                  }
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
      if (savedName != null) {
        setState(() {
          _userName = savedName;
        });
      }
    }
  }

  // ... (rest of your build method) ...

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // ... (your existing Scaffold code) ...
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    '$_userName Xylophone', // Display username
                    style: GoogleFonts.pacifico(
                      // ... (your existing text style) ...
                    ),
                  ),
                ),
                // ... (rest of your Column children) ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}