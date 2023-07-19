// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unused_element


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';
import 'Add_postfA.dart';
import 'addPets.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);
  @override
  State<Add> createState() => _Onboar3State();
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

class _Onboar3State extends State<Add> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.upload,
        ),
        onPressed: () => _selectImage(context),
      ),
    );

    // ignore: dead_code

    // ignore: dead_code
  }
}
