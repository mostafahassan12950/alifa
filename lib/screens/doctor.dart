// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, unused_element

import 'dart:convert';

import 'package:aliifa/constants/err_handling.dart';
import 'package:aliifa/screens/pets_user.dart';
import 'package:aliifa/screens/search/search_solid.dart';
import 'package:aliifa/screens/search/search_clinic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants/constant.dart';

import '../constants/loder.dart';
import '../constants/notifactionButton.dart';
import '../constants/snackbar.dart';
import '../models/clinic.dart';
import '../models/pets.dart';
import '../models/solid.dart';
import '../provider/provider.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class Doctor extends StatefulWidget {
  const Doctor({Key? key}) : super(key: key);
  @override
  State<Doctor> createState() => _Onboar3State();
}

class _Onboar3State extends State<Doctor> {
  @override
  void initState() {
    super.initState();
  }

  var currnts = 0;
  bool isLikeAnimating = false;
  String selectedType = ""; // keep track of the selected pet type
  Future<List<clinic>> fetchAllFood(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<clinic> solidtList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/clinic/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": 'Bearer ${userProvider.user.token}'
        },
      );
      print(res.body);
      print(solidtList.length);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          var decoded = jsonDecode(res.body);
          if (decoded["status"] == "successful") {
            List<dynamic> data = decoded["data"];
            for (int i = 0; i < data.length; i++) {
              Map<String, dynamic> item = data[i];
              clinic c = clinic(
                id: item["id"],
                name: item["name"],
                phone: item["phone"],
                country: item["country"],
                city: item["city"],
                rating: item["rating"],
              );
              solidtList.add(c);
            }
          } else {
            showSnackBar(context, "Error retrieving data");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return solidtList;
  }

  Widget build(BuildContext context) {

    return      RefreshIndicator(
      color: color8,
  onRefresh: () async {
    await Future.delayed(const Duration(seconds: 3));
    await fetchAllFood(context);
    setState(() {});
  },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: 1000,
              child: Column(children: [
                SizedBox(
                  height: 35,
                ),
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
                    SizedBox(
                      width: 100,
                    ),
                    Text('Doctors',
                        style: TextStyle(
                            color: color8,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 238, 238, 235),
                    ),
                    width: 420,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search3(),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(
                              CupertinoIcons.camera_fill,
                              color: color8,
                            ),
                          ),
                          icon: Icon(
                            Icons.search,
                            color: color8,
                          ),
                          hintText: " search for a clinic  :",
                          fillColor: color8,
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                Expanded(
                  flex: 1,
                  child: FutureBuilder<List<clinic>>(
                    future: fetchAllFood(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<clinic> petList = snapshot.data!;
    
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: petList.length,
                            itemBuilder: (context, index) {
                              final petDataa = petList[index];
                              return InkWell(
                                onTap: () {
                                  // Handle tap event
                                },
                                child: Column(children: [
                                  Container(
                                    color: color8,
                                    height: 170,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Text(
                                            petDataa.name.toString(),
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          RatingBar.builder(
                                            initialRating: double.parse(petDataa
                                                .rating
                                                .toString()), // Pass the clinic's rating value here
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  251, 214, 134, 1),
                                              size: 5,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons.location_solid,
                                              color: Color.fromARGB(
                                                  251, 214, 134, 1),
                                            ),
                                            Text(
                                              petDataa.city.toString(),
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 30,
                                            ),
                                            InkWell(
                                              child: Container(
                                                width: 100,
                                                height: 45,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(CupertinoIcons.phone,
                                                        color: Colors.white),
                                                    const Text('call',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19,
                                                        )),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                decoration: const ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  color: Color.fromARGB(
                                                      251, 214, 134, 1),
                                                ),
                                              ),
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) => Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        border: Border.all(
                                                            color: Colors.black)),
                                                    height: 60,
                                                    width: 200,
                                                    child: Center(
                                                      child: InkWell(
                                                        onTap: () {
                                                          calling(petDataa.phone
                                                              .toString());
                                                        },
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Icon(
                                                                Icons.call,
                                                                size: 40,
                                                                color: color8,
                                                              ),
                                                            ),
                                                            Text(
                                                                "call ${petDataa.phone}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize:
                                                                        15)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            InkWell(
                                              child: Container(
                                                width: 150,
                                                height: 45,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                        CupertinoIcons
                                                            .chat_bubble_2,
                                                        color: Colors.white),
                                                    const Text('whatsapp',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 19,
                                                        )),
                                                  ],
                                                ),
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                decoration: const ShapeDecoration(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  color: Color.fromARGB(
                                                      251, 214, 134, 1),
                                                ),
                                              ),
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) => Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                        border: Border.all(
                                                            color: Colors.black)),
                                                    height: 60,
                                                    width: 200,
                                                    child: Center(
                                                      child: InkWell(
                                                        onTap: () {
                                                          launch(
                                                              'https://wa.me/+20${petDataa.phone}');
                                                        },
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {},
                                                              child: Image.asset(
                                                                  "asset/img/R.png"),
                                                            ),
                                                            Text(
                                                                "chat  ${petDataa.phone}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize:
                                                                        15)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 30,),]),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  calling(String petDataa) async {
    var url = 'tel:${petDataa}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
        // Container(
        //           padding: EdgeInsets.all(0),
        //           margin: EdgeInsets.symmetric(horizontal: 5),
        //           decoration: BoxDecoration(
        //             color: Color.fromARGB(255, 255, 255, 255),
        //             borderRadius: BorderRadius.circular(10),
                   
        //           ),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               InkWell(
        //                 onTap: (() {
        //                   setState(() {
        //                     currnts = 0;
        //                   });
        //                 }),
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(
        //                       vertical: 12,horizontal: 5 ),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Text(" Dog ",
        //                       style: TextStyle(
        //                           color: currnts == 0 ? color8 : color8.withOpacity(.4),
        //                         fontSize: 20,
        //                           fontWeight: FontWeight.bold)),
        //                 ),
        //               ),
        //               InkWell(
        //                 onTap: (() {
        //                   setState(() {
        //                     currnts = 1;
        //                   });
        //                 }),
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(
        //                       vertical: 12,horizontal: 5 ),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Text(" cats ",
        //                       style: TextStyle(
        //                           color: currnts == 1 ? color8 : color8.withOpacity(.4),
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold)),
        //                 ),
        //               ),
        //             InkWell(
        //                 onTap: (() {
        //                   setState(() {
        //                     currnts = 2;
        //                   });
        //                 }),
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(
        //                       vertical: 12,horizontal: 5  ),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Text(" Fishes ",
        //                       style: TextStyle(
        //                           color: currnts == 2 ? color8 : color8.withOpacity(.4),
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold)),
        //                 ),
        //               ),    InkWell(
        //                 onTap: (() {
        //                   setState(() {
        //                     currnts = 3;
        //                   });
        //                 }),
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(
        //                       vertical: 12,horizontal: 5  ),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Text(" Birds ",
        //                       style: TextStyle(
        //                           color: currnts == 3 ? color8 : color8.withOpacity(.4),
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold)),
        //                 ),
        //               ),    InkWell(
        //                 onTap: (() {
        //                   setState(() {
        //                     currnts = 4;
        //                   });
        //                 }),
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(
        //                       vertical: 12,horizontal: 5 ),
        //                   decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: Text(" Others ",
        //                       style: TextStyle(
        //                           color: currnts == 4 ? color8 : color8.withOpacity(.4),
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold)),
        //                 ),
        //               )
                
        //             ],
        //           )),
           