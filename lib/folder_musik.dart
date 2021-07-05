import 'package:audio_player/audio1.dart';
import 'package:audio_player/audio2.dart';
import 'package:audio_player/audio3.dart';
import 'package:flutter/material.dart';

import 'audio.dart';

class FolderMusik extends StatefulWidget {
  const FolderMusik({Key? key}) : super(key: key);

  @override
  _FolderMusikState createState() => _FolderMusikState();
}

class _FolderMusikState extends State<FolderMusik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lagu Tradisional Suku Ngalum",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: Container(
                height: 60,
                width: 250,
                child: Center(
                    child: Text(
                  "Folder 1",
                  style: TextStyle(fontSize: 30),
                )),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => AudioPlayerScreens()));
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                height: 60,
                width: 250,
                child: Center(
                    child: Text(
                  "Folder 2",
                  style: TextStyle(fontSize: 30),
                )),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => AudioPlayer1Screens()));
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                height: 60,
                width: 250,
                child: Center(
                    child: Text(
                  "Folder 3",
                  style: TextStyle(fontSize: 30),
                )),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => AudioPlayer2Screens()));
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              child: Container(
                height: 60,
                width: 250,
                child: Center(
                    child: Text(
                  "Folder 4",
                  style: TextStyle(fontSize: 30),
                )),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => AudioPlayer3Screens()));
              },
            ),
          ],
        ),
      )),
    );
  }
}
