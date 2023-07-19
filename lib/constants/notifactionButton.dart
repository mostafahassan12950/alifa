// ignore_for_file: prefer_const_constructors, camel_case_types


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'constant.dart';

class notifactionButton extends StatelessWidget {
 
  const notifactionButton({
    Key? key,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return    IconButton(
                          onPressed: () {   },
                          icon: Icon(
                            CupertinoIcons.bell_fill,
                            color: color8,
                          ),
                        );
  }
}
