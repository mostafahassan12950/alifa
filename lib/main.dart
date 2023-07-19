import 'package:aliifa/provider/provider.dart';
import 'package:aliifa/screens/v_login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'Admin_screen/admin.dart';
import 'responsive/mobile_screen_layout.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) {
      return UserProvider();
    }),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "myApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider.of<UserProvider>(context).user.token!.isNotEmpty
          ? Provider.of<UserProvider>(context).user.role == "admin"
              ? Admin()
              : mobile_screen_layout()
          : V_logn(),
    );
  }
}
