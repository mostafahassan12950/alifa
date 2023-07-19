import 'dart:async';

import 'package:aliifa/onboarding/onboarding1.dart';

import 'package:flutter/material.dart';

import '../constants/constant.dart';

class Splash1 extends StatefulWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  State<Splash1> createState() => _Onboar3State();
}

class _Onboar3State extends State<Splash1> {
  int _index = 0;

  final List<String> _imagePaths = [
    "asset/img/logo2 1.png",
    "asset/img/logo2 1 (1).png",
    "asset/img/logo2 1 (2).png",
    "asset/img/logo2 1 (3).png",
    "asset/img/logo2 1 (4).png",
    "asset/img/show.png"
  ];

  @override
  void initState() {
    super.initState();
    _changeImage();
    
  }

  void _changeImage() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _index = (_index + 1) % _imagePaths.length;
    });

    if (_index == _imagePaths.length - 1) {
      // انتهاء عرض الصور ، قم بالانتقال إلى الصفحة الأخرى
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => onboarding1()),
      );
    } else {
      _changeImage();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:color8,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Image(
                  key: ValueKey<int>(_index),
                  image: AssetImage(_imagePaths[_index]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Image(
                  image: AssetImage("asset/img/Happy Pet.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
