
import 'package:aliifa/constants/constant.dart';
import 'package:aliifa/screens/pets_user.dart';
import 'package:aliifa/screens/search/search_solid.dart';
import 'package:aliifa/screens/search/search_clinic.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';


import '../models/pets.dart';
import 'search/Search_pets.dart';
import 'doctor.dart';
import 'food&acc.dart';
import 'pets.dart';
import 'dart:convert';


import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../constants/err_handling.dart';
import '../constants/snackbar.dart';
import '../provider/provider.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Home> {
 var currnts = 0;
  bool isLikeAnimating = false;
  String selectedType = ""; // keep track of the selected pet type
  Future<List<Pet>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Pet> petList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/pet/all'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Bearer ${userProvider.user.token}'
      });
      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          var decoded = jsonDecode(res.body);
          if (decoded["status"] == "successful") {
            List<dynamic> data = decoded["data"]["rows"];
            for (int i = 0; i < data.length; i++) {
              Map<String, dynamic> item = data[i];
              String type = item["type"]; // get the pet type from the server
              // map the type to the list of pet types
              if (type == "dog") {
                type = "Dog";
              } else if (type == "cat") {
                type = "Cat";
              } else {
                type = "Other";
              }
              Pet pet = Pet.fromJson(item); // create a new pet object
              pet.type = type; // set the pet type
              petList.add(pet); // add the pet to the list
            }
          } else {
            showSnackBar(context, "Error retrieving data");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return petList;
  }

  final List<String> petTypes = [
    "Dog",
    "Cat",
    "Other",
  ];
  Future<void> deletePost(
      String postId, String usertoken, BuildContext context) async {
    try {
      http.Response res =
          await http.delete(Uri.parse('$uri/pet/${postId}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Bearer ${usertoken}'
      });
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "deon");
            Navigator.pop(
              context,
            );
            Navigator.pop(
              context,
            );
            Navigator.pop(
              context,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
_selectImage(BuildContext parentContext) async {
  return showDialog(
    context: parentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: const Text('search  '),
        children: <Widget>[
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [Image.asset("asset/img/5.png"),
                  
                  const Text('search for Pets'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(),
                  ),
                );
              }),
          SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [ Image.asset("asset/img/f4a868a5-ab3a-4fc5-ad2a-075085eb6657 (1).png"),
                  SizedBox(width: 10,),
                  
                  const Text('search for solid'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search2(),
                  ),
                );
              }),
              SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [ Image.asset("asset/img/6.png",width: 70,),
                  SizedBox(width: 10,),
                  
                  const Text('search for clinic'),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search3(),
                  ),
                );
              }),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

     return RefreshIndicator(
      color: color8,
  onRefresh: () async {
    await Future.delayed(const Duration(seconds: 3));
    await fetchAllProducts(context);
    setState(() {});
  },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView
        (physics: AlwaysScrollableScrollPhysics(),

          child: Container(
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            imgeAlifa,
                            SizedBox(
                              width: 200,
                            ),
                            IconButton(
                              onPressed:   () {
                                _selectImage(context);
                              },
                              icon: Icon(
                                CupertinoIcons.search_circle_fill,size: 30,
                                color: color8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 238, 238, 235),
                          ),
                          width: 420,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            onTap: (){ Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Search(),
                                  ),
                                );},
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
                                hintText: " search for a pets :",
                                fillColor: color8,
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "What are you looking for ?",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetListScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  width: 169,
                                  height: 98,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        CupertinoIcons.paw,
                                        color: color8,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "pets",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset("asset/img/5.png")
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () {Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Doctor(),
                                  ),
                                );},
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  width: 169,
                                  height: 98,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        CupertinoIcons.briefcase,
                                        color: color8,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Doctor",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        "asset/img/6.png",
                                        width: 70,
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Food(),
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    boxShadow: [
                                      BoxShadow(),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  width: 339,
                                  height: 98,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        CupertinoIcons.cart_badge_plus,
                                        color: color8,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "food and Accesories",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Image.asset(
                                        "asset/img/7.png",
                                      )
                                    ],
                                  )),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Newly Added",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetListScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'See More ',
                                style: TextStyle(
                                  color: Color.fromARGB(244, 231, 168, 74),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                 Expanded(  
                  flex: 1,
                  child: FutureBuilder<List<Pet>>(
                    future: fetchAllProducts(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Pet> petList = snapshot.data!;
                        if (selectedType.isNotEmpty) {
                          // filter the pet list by type if a type is selected
                          petList = petList
                              .where((pet) => pet.type == selectedType)
                              .toList();
                        }                  
                         petList.sort((a, b) => b.date_added!.compareTo(a.date_added!));
                        return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: petList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final petDataa = petList[index];
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => SafeArea(
                                      child: Container(
                                        child: Stack(children: [
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            child: Image.network(
                                              petDataa.image_url.toString(),
                                              fit: BoxFit.cover,
                                              width: double.maxFinite,
                                              height: 300,
                                            ),
                                          ),
                                          Positioned(
                                            left: 20,
                                            top: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                              },
                                              icon: Icon(
                                                CupertinoIcons.chevron_back,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 248, 246, 246),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 20,
                                            top: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                print(userProvider.toString());
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return SimpleDialog(
                                                      children: [
                                                        if (userProvider.user.id ==
                                                                petDataa.user_id ||
                                                            userProvider.user.role ==
                                                                'admin')
                                                          SimpleDialogOption(
                                                            onPressed: () async {
                                                              deletePost(
                                                                  petDataa.id
                                                                      .toString(),
                                                                  userProvider
                                                                      .user.token
                                                                      .toString(),
                                                                  context);
                                                            },
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    20),
                                                            child: const Text(
                                                              "Delete post",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          )
                                                        else
                                                          const SimpleDialogOption(
                                                            padding:
                                                                EdgeInsets.all(20),
                                                            child: Text(
                                                              "Can not delete this post ✋",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        SimpleDialogOption(
                                                          onPressed: () async {
                                                            Navigator.of(context)
                                                                .pop();
                                                          },
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  20),
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.more_vert,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 248, 246, 246),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 280,
                                            child: Container(
                                              padding: const EdgeInsets.all(12.0),
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              height: 500,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(30),
                                                    topRight: Radius.circular(30),
                                                  )),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 70,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.topRight,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        petDataa.name
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                11,
                                                                                11,
                                                                                11),
                                                                            fontSize:
                                                                                25),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .location_solid,
                                                                    color: color8,
                                                                  ),
                                                                  Text(
                                                                      petDataa.city
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(
                                                                                  0.8),
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("type:",
                                                                      style: TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  11,
                                                                                  11,
                                                                                  11),
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                      " ${petDataa.type.toString()}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(
                                                                                  0.8),
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("status: ",
                                                                      style: TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  11,
                                                                                  11,
                                                                                  11),
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                      "${petDataa.status}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(
                                                                                  0.8),
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("gender:",
                                                                      style: TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  11,
                                                                                  11,
                                                                                  11),
                                                                          fontSize:
                                                                              22)),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                      " ${petDataa.gender}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(
                                                                                  0.8),
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  "description:",
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              11,
                                                                              11,
                                                                              11),
                                                                      fontSize: 22)),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                width: 200,
                                                                child: Text(
                                                                  " ${petDataa.description.toString()}  ",
                                                                  style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize: 15,
                                                                  ),
                                                                  overflow: TextOverflow
                                                                      .clip, // أو TextOverflow.ellipsis
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  petDataa.date_added !=
                                                                          null
                                                                      ? DateFormat(
                                                                              'MMMM d, y')
                                                                          .format(DateTime.parse(
                                                                              petDataa
                                                                                  .date_added!))
                                                                      : '',
                                                                  style: TextStyle(
                                                                    fontSize: 18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "\LE ${petDataa.price}",
                                                              style: TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          11,
                                                                          11,
                                                                          11),
                                                                  fontSize: 22)),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            height: 60,
                                                            width: 60,
                                                            child: Center(
                                                              child: InkWell(
                                                                onTap: () {},
                                                                child: Icon(
                                                                  Icons
                                                                      .mode_comment_outlined,
                                                                  size: 40,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            height: 60,
                                                            width: 60,
                                                            child: Container(
                                                              height: 150,
                                                              child: Center(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                      isScrollControlled:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    8),
                                                                            border: Border.all(
                                                                                color:
                                                                                    Colors.black)),
                                                                        height: 60,
                                                                        width: 200,
                                                                        child: Center(
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              calling(petDataa
                                                                                  .user_phone
                                                                                  .toString());
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap:
                                                                                      () {},
                                                                                  child:
                                                                                      Icon(
                                                                                    Icons.call,
                                                                                    size: 40,
                                                                                    color: color8,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                    "call ${petDataa.user_phone}",
                                                                                    style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Icon(
                                                                    Icons.call,
                                                                    size: 40,
                                                                    color: color8,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 30,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black)),
                                                            height: 60,
                                                            width: 60,
                                                            child: Center(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    context: context,
                                                                    builder:
                                                                        (context) =>
                                                                            Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  8),
                                                                          border: Border.all(
                                                                              color: Colors
                                                                                  .black)),
                                                                      height: 60,
                                                                      width: 200,
                                                                      child: Center(
                                                                        child:
                                                                            InkWell(
                                                                          onTap: () {
                                                                            launch(
                                                                                'https://wa.me/+20${petDataa.user_phone}');
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              InkWell(
                                                                                onTap:
                                                                                    () {},
                                                                                child:
                                                                                    Image.asset("asset/img/R.png"),
                                                                              ),
                                                                              Text(
                                                                                  "chat  ${petDataa.user_phone}",
                                                                                  style:
                                                                                      TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 15)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Image.asset(
                                                                    "asset/img/R.png"),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            left: 12,
                                            child: Row(
                                              children: [
                                               
                                                SizedBox(
                                                  width: 60,
                                                ),
                                                Container(
                                                  width: 250,
                                                  height: 60,
                                                  padding: const EdgeInsets.all(12.0),
                                                  decoration: BoxDecoration(
                                                    color: color8,
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                  ),
                                                  child: Stack(
                                                      alignment: Alignment.topRight,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                " ${petDataa.user_name.toString()}",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontSize: 17)),
                                                            Row(
                                                              children: [
                                                                IconButton(
                                                                  onPressed: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                            Profile3(phone:petDataa.user_phone.toString() ,
                                                                          uid: petDataa
                                                                              .user_id
                                                                              .toString(),
                                                                          name_user: petDataa
                                                                              .user_name
                                                                              .toString(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  icon: Icon(
                                                                    CupertinoIcons
                                                                        .chevron_right_circle_fill,
                                                                    color:
                                                                        Colors.white,
                                                                  ),
                                                                ),
                                                                Text("profile",
                                                                    style: TextStyle(
                                                                        color: Color
                                                                            .fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255),
                                                                        fontSize:
                                                                            13)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: .25,
                                        )
                                      ]),
                                  child: Column(
                                    children: [
                                      Stack(alignment: Alignment.center, children: [
                                        Image.network(
                                          petDataa.image_url.toString(),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                     ]),
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(petDataa.name.toString(),
                                                          style: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255, 11, 11, 11),
                                                              fontSize: 14)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("\LE ${petDataa.price}",
                                                          style: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255, 11, 11, 11),
                                                              fontSize: 10)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons.location_solid,
                                                        color: color8,
                                                      ),
                                                      Text(petDataa.city.toString(),
                                                          style: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255, 11, 11, 11),
                                                              fontSize: 15)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
