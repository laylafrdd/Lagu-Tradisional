//Layla Frida Luthfyana / Magang Universitas Kristen Satya Wacana
import 'dart:async';
import 'package:audio_player/folder_musik.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_player/audio.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => FolderMusik()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[50],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Image.asset("assets/images/ssicon.png",
                  height: 120.0, width: 230.0),
              SizedBox(height: 10),
              CupertinoActivityIndicator()
            ],
          ),
        ));
  }
}
