// ignore_for_file: unused_element, avoid_unnecessary_containers, no_logic_in_create_state

import 'dart:typed_data';

import 'package:aliifa/constants/constant.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


import '../constants/notifactionButton.dart';
import '../screens/pets.dart';

Uint8List? _image;

List<Item> items = [
  Item(
      name: "French bulldog ",
      imgPath: "asset/img/mmmm.jpg",
      price: 20000,
      location: "cairo"),
  Item(
      name: "Egypt bulldog ",
      imgPath: "asset/img/mm.jpg",
      price: 12000,
      location: "fayoum"),
  Item(
      name: "Egypt bulldog",
      imgPath: "asset/img/mmm.jpg",
      price: 17000,
      location: "Giza"),
  Item(
      name: "French bulldog",
      imgPath: "asset/img/m.jpg",
      price: 30000,
      location: "aswan"),
  Item(
      name: "French bulldog",
      imgPath: "asset/img/n.png",
      price: 15000,
      location: "Alexandria"),
  Item(
      name: "French bulldog",
      imgPath: "asset/img/nn.png",
      price: 26000,
      location: "Giza"),
  Item(
      name: "French bulldog",
      imgPath: "asset/img/nnn.png",
      price: 11000,
      location: "Suez"),
  Item(
      name: "French bulldog",
      imgPath: "asset/img/nnnn.png",
      price: 15500,
      location: "Ismailia"),
];

class Item {
  String imgPath;
  String name;
  double price;
  String location;

  Item(
      {required this.imgPath,
      required this.name,
      required this.price,
      required this.location});
}

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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

                        imgeAlifa,
                        SizedBox(
                          width: 50,
                        ),
                        Text('admin',
                        style: TextStyle(color: Colors.black,
                            fontSize: 22,

                        )),
                        
                        SizedBox(
                          width: 70,
                        ),
                        notifactionButton(),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 238, 238, 235),
                      ),
                      width: 420,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
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
                          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PetListScreen(),
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
                          onTap: () {},
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
                          onTap: () {},
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
                            onPressed: () {},
                            child: Text(
                              'See More ',
                              style: TextStyle(
                                  color: Color.fromARGB(244, 231, 168, 74),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ],
                )),
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                          Image.asset(
                            items[index].imgPath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 106,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("${items[index].name} ",
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
                                      Text(" \$ ${items[index].price} ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11),
                                              fontSize: 10)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.location_solid,
                                        color: color8,
                                      ),
                                      Text(" ${items[index].location} ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11),
                                              fontSize: 10)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, file_names, unused_label, sort_child_properties_last, duplicate_ignore, unused_local_variable
}
