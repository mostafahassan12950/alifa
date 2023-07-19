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

class onboarding3 extends StatefulWidget {
  const onboarding3({Key? key}) : super(key: key);

  @override
  State<onboarding3> createState() => _Onboar3State();
}

class _Onboar3State extends State<onboarding3> {
  

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
                          builder: (context) => V_logn(),
                        ),
                      );
                    },
                    child: Text(
                      "skip",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),const SizedBox(
                height: 40,
              ),
               Row(
                children: [
                  const SizedBox(
                    width: 38,
                  ),
                  Image(
                    image: AssetImage(
                        "asset/img/406b8b2c-0c87-4688-9882-cf78d99ca00c 1 (1).png"),
                    height: 100,
                
                  ),
                ],
              ),
              
              Row(
                children: [
                  const SizedBox(
                    width: 38,
                  ),
                  Image(
                    image: AssetImage(
                        "asset/img/b7844459-0e87-4697-99c2-3133c2a765d4 1 (1).png"),
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
                    "Make A New Friend",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Get your favourite pet",
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
                    "At your location",
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
                  Container(
                          width: 50,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.rectangle,
                              color: color8)),
                      SizedBox(
                        width: 10,
                      ),   ],
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
