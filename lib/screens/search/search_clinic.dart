import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constant.dart';
import '../../constants/err_handling.dart';
import '../../constants/snackbar.dart';
import '../../models/clinic.dart';
import '../../provider/provider.dart';


class Search3 extends StatefulWidget {
  const Search3({Key? key}) : super(key: key);

  @override
  State<Search3> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Search3> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(showUser);
  }

  showUser() {
    setState(() {});
  }

  @override
  void dispose() {
    myController.dispose();

    super.dispose();
  }
 
var currnts = 0;
  bool isLikeAnimating = false;
  String searchQuery = 'Adopted';
   // keep track of the selected pet type
Future<List<clinic>> fetchAllFood(BuildContext context, String searchQuery) async {
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
            if (searchQuery.isEmpty ||
                c.name!.toLowerCase().contains(searchQuery.toLowerCase())) {
              solidtList.add(c);
            }
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

  @override
 
  Widget build(BuildContext context) {

    return   RefreshIndicator(
      color: color8,
  onRefresh: () async {
    await Future.delayed(const Duration(seconds: 3));
    await fetchAllFood(context, searchQuery );
    setState(() {});
  },
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: color8,
          title: Text('clinic List'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:SingleChildScrollView (
            physics: AlwaysScrollableScrollPhysics(),

            child: Container(height: 1000,
              child: Column(
                
                children: [
                 
                  Container( decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 238, 238, 235),
                    ),
                    width: 420,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search clinic by name',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                       Expanded(
                  flex: 1,
                  child: FutureBuilder<List<clinic>>(
                    future: fetchAllFood(context,searchQuery),
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
         ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}  

calling(String petDataa) async {
    var url = 'tel:${petDataa}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

