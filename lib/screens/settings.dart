import 'package:aliifa/screens/user/pets_me.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constant.dart';
import '../constants/notifactionButton.dart';
import '../provider/provider.dart';
import 'user/solid_Me.dart';
import 'EditProfile.dart';

class settings extends StatefulWidget {
  const settings({
    Key? key,
  }) : super(key: key);

  @override
  @override
  State<settings> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<settings> {
  var userData = {};
  getData() async {
    // Get data from DB

    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<UserProvider>(context).user;

    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                    "https://th.bing.com/th/id/OIP.z0CqhczV2cjczi2F0O_UgQHaHa?w=199&h=199&c=7&r=0&o=5&pid=1.7"),
                radius: 33,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    " ${userdata.name.toString()}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              subtitle: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(child: EditProfile()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "View and edit profile ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  )),
              trailing: notifactionButton(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '  Account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),             SizedBox(height: 10,),
 
             Text(
                " ${userdata.phone.toString()}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile2(),
                  ),
                );
              },
              leading: Icon(
                CupertinoIcons.paw,
                color: color8,
              ),
              title: Text(
                "My Pets",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Foodprofil(),
                  ),
                );
              },
              leading: Icon(
                CupertinoIcons.bag,
                color: color8,
              ),
              title: Text(
                "My solid ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
           
            SizedBox(
              height: 20,
            ),
            Text(
              '  Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.globe,
                color: color8,
              ),
              title: Text(
                "Language",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.bell_fill,
                color: color8,
              ),
              title: Text(
                "Allow Notifications ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            Text(
              '  Reach out',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
            ListTile(
              onTap: () =>  calling(),
              leading: Icon(
                CupertinoIcons.phone,
                color: color8,
              ),
              title: Text(
                "Call us ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: (() async {}),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 69, 69),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("log out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  calling() async {
    var url = 'tel:01016899841';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, file_names, unused_label, sort_child_properties_last, duplicate_ignore, unused_local_variable

/*   appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
await AuthMethods().signOut();              
             
            },
            label: Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: color8,
        title: Text("Profile Page"),
      ),
      */