// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unused_element

import 'dart:async';

import 'package:aliifa/responsive/mobile_screen_layout.dart';
import 'package:aliifa/provider/provider.dart';
import 'package:aliifa/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/v_login.dart';
import '../Admin_screen/admin.dart';
import '../constants/constant.dart';
import 'onboarding3.dart';

class onboarding2 extends StatefulWidget {
  const onboarding2({Key? key}) : super(key: key);

  @override
  State<onboarding2> createState() => _Onboar3State();
}

class _Onboar3State extends State<onboarding2> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                     Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.chevron_back,
                          color: color8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width:200,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => onboarding3(),
                        ),
                      );
                    },
                    child: Text(
                      "skip",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 38,
                  ),
                  Image(
                    image: AssetImage(
                        "asset/img/0489553d-d5dc-4a6f-a547-58e7d46459b0 1 (1).png"),
                    height: 250,
                    width: 280,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Text(
                    "Veterinarian Checks",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Book an Appointment",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "of veterinarian Online",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                    
                      Container(
                          width: 50,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.rectangle,
                              color: color8)),
                      SizedBox(
                        width: 10,
                      ),  Container(
                          width: 100,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.rectangle,
                              color: color8)),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 50,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.rectangle,
                              color: color8)),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              ),
            ],
          )),
    );

    // ignore: dead_code

    // ignore: dead_code
  }
}
