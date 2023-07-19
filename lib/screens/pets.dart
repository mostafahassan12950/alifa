import 'dart:convert';

import 'package:aliifa/screens/pets_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../constants/constant.dart';
import '../constants/err_handling.dart';
import '../constants/snackbar.dart';
import '../models/pets.dart';
import '../provider/provider.dart';
import 'search/Search_pets.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
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
            showSnackBar(context, "deleted");
if (Navigator.canPop(context)) {
  Navigator.pop(context);
}
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return   RefreshIndicator(
      color: color8,
  onRefresh: () async {
    await Future.delayed(const Duration(seconds: 3));
    await fetchAllProducts(context);
    setState(() {});
  },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
    
            child: Container(height: 1000,
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
                    Text('pets',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    SizedBox(
                      width: 130,
                    ),
                  
                  ],
                ),
                SizedBox(
                  height: 15,
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
                          builder: (context) => Search(),
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
                        hintText: " search for a pets :",
                        fillColor: color8,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Pet type buttons here
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                currnts = 0;
                                selectedType = "";
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "All",
                                style: TextStyle(
                                  color:
                                      currnts == 0 ? color8 : color8.withOpacity(.4),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currnts = 1;
                                selectedType = "Dog";
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Dog",
                                style: TextStyle(
                                  color:
                                      currnts == 1 ? color8 : color8.withOpacity(.4),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currnts = 2;
                                selectedType = "Cat";
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Cat",
                                style: TextStyle(
                                  color:
                                      currnts == 2 ? color8 : color8.withOpacity(.4),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currnts = 3;
                                selectedType = "Other";
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Other",
                                style: TextStyle(
                                  color:
                                      currnts == 3 ? color8 : color8.withOpacity(.4),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                                                    height: 3,
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
