import 'package:aliifa/screens/login.dart';
import 'package:aliifa/screens/register.dart';

import 'package:flutter/material.dart';

import '../constants/constant.dart';

int currnt = 0;
final _schedulew = [
  Login(),
  Register(),
];

class V_logn extends StatefulWidget {
  @override
  State<V_logn> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<V_logn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.symmetric(horizontal: 56.6),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 0.2,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (() {
                          setState(() {
                            currnt = 0;
                          });
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          decoration: BoxDecoration(
                              color: currnt == 0 ? color8 : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(" login ",
                              style: TextStyle(
                                  color: currnt == 0 ? Colors.white : color8,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          setState(() {
                            currnt = 1;
                          });
                        }),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          decoration: BoxDecoration(
                              color: currnt == 1 ? color8 : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(" sign up ",
                              style: TextStyle(
                                  color: currnt == 1 ? Colors.white : color8,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              _schedulew[currnt],
            ],
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, file_names, unused_label, sort_child_properties_last, duplicate_ignore, unused_local_variable

