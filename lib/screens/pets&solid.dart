// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unused_element

import 'package:aliifa/screens/user/pets_me.dart';
import 'package:aliifa/screens/user/solid_Me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/constant.dart';
import '../utils/utils.dart';
import 'add_POST/Add_postfA.dart';
import 'add_POST/addPets.dart';

class MY extends StatefulWidget {
  const MY({Key? key}) : super(key: key);
  @override
  State<MY> createState() => _Onboar3State();
}

_selectImage(BuildContext parentContext) async {
  return showDialog(
    context: parentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('add Pots'),
        children: <Widget>[
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('add Pets'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Add_post(),
                  ),
                );
              }),
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('food*accessories'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Add_postfA(),
                  ),
                );
              }),
        ],
      );
    },
  );
}

class _Onboar3State extends State<MY> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(33.0),
      child: Column(children: [
        SizedBox(height: 50,),
        InkWell(
          onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile2(),
                        ),
                      );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black)),
            height: 300,
            width: 400,
            child: Column(
              children: [
               
                Row(
                  children: [
                    const SizedBox(
                      width: 38,
                    ),
                    Image(
                      image: AssetImage("asset/img/OIP (3).jpg"),
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
               Text('my pets',
                    style: TextStyle(
                        color: color8,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),],
            ),
          ),
        ),        SizedBox(height: 30,),

            InkWell(
          onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Foodprofil(),
                        ),
                      );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black)),
            height: 300,
            width: 400,
            child: Column(
              children: [
               
                Row(
                  children: [
                    const SizedBox(
                      width: 38,
                    ),
                    Image(
                      image: AssetImage("asset/img/OIP (2).jpg"),
                      height: 250,
                      width: 250,
                    ),
                  ],
                ),
               Text('my solid',
                    style: TextStyle(
                        color: color8,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),],
            ),
          ),
        ),   
      ]),
    ));
    // ignore: dead_code

    // ignore: dead_code
    // ignore: dead_code
    // ignore: dead_code
  }
}
