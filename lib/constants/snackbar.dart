 
import 'package:flutter/material.dart';

import 'constant.dart';
 


 void showSnackBar(BuildContext context, String text) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds:6000),
      content: Text(text,style: TextStyle(color: Colors.white),),
      action: SnackBarAction(label: "close", onPressed: () {}),
      backgroundColor: color8,
    )
    );
 }