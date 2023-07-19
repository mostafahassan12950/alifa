// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:aliifa/constants/textfiled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../constants/err_handling.dart';
import '../../constants/snackbar.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../../models/pets.dart';
import '../../provider/provider.dart';

class Add_post extends StatefulWidget {
  Add_post({Key? key}) : super(key: key);

  @override
  State<Add_post> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Add_post> {
  // ignore: unused_field

  bool _isLoading = false;
  bool _isSale = true;
  @override
  void initState() {
    super.initState();
  }

  void postImage() async {
    // start the loading

    // upload to storage and db
  }

  int myNumber = 0;
  void uploadPost({
    required BuildContext context,
    required String name,
    required String description,
    required String status,
    required String gender,
    required String type,
    required int? price,
    required String city,
    required String image_url,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
   
    try {
      Pet pets = Pet(
        description: description,
        name: name,
        image_url: image_url,
        status: status,
        type: type,
        price: price,
        city: city,
        gender: gender,
      );

      http.Response res = await http.post(
        Uri.parse("$uri/pet/mine"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": 'Bearer ${userProvider.user.token}'
        },
        body: pets.toJson(),
      );
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            setState(() {
              _isLoading = false;
            });
            print(res.body);
            showSnackBar(context, "successfully complete the form.");
            clearImage();
            Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
          });
    } catch (e) {}
// creates unique id base // creates unique id based on time
  }

  void clearImage() {
    setState(() {
      _file = null;
      _statusController.text = "";
      _typeController.text = "";
      _PriceController.text = "";
      _DescriptionController.text = "";
      _GenderController.text = "";
      _LocationController.text = "";
      _nameController.text = "";
    });
  }

  final _formKey = GlobalKey<FormState>();
  var _statusController = TextEditingController();
  var _nameController = TextEditingController();
  var _typeController = TextEditingController();
  var _PriceController = TextEditingController();
  var _GenderController = TextEditingController();
  var _LocationController = TextEditingController();
  var _DescriptionController = TextEditingController();

  List<String> status = ["adopt", "sale", "found", "lost"];
  List<String> type = [
    "dog",
    "cat",
    "other",
  ];
  List<String> Gender = ["female", "male"];
  List<String> Location = [
    'Cairo ',
    '10th of Ramadan',
    '6th of October',
    'fayoum',
    'Ismailia',
    'Suez',
    'Port Said',
    'Giza',
    'Asyut',
    'Aswan',
    'Alexandria '
  ];

  void dispose() {
    super.dispose();
  }

  XFile? _file;
  Uint8List? _bytes;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _file = pickedFile;
      _bytes = await pickedFile.readAsBytes();
      setState(() {});
      if (_file != null) {
        final _bytes = File(_file!.path);
      }
    }
  }

  void clearImage1() {
    setState(() {
      _file = null;
    });
  }

  String image_uri = "";

  Future<bool> uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    // Create a multipart request to send the image to the server
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$uri/upload-image'),
    );

    // Add the image file to the request
    if (_file != null) {
      final file = await http.MultipartFile.fromPath('image', _file!.path);
      request.files.add(file);
    } else {
    }

    // Send the request and wait for the response
    final response = await http.Response.fromStream(await request.send());
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (responseBody['image_url'] != null) {
      image_uri = responseBody['image_url'];
      // rest of the code that uses the `image_uri` variable
    } else {
    }

    // Return true if the image was uploaded successfully
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);

        _isLoading = false;
      });
      showSnackBar(context,
          "Your image uploaded successfully. Please complete the form.");

      clearImage1();

      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
          child: filed(),
        ),
      );
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('must'),
          content: Text('complete the form'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return true;
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, "Failed to upload image.");

      // Handle the exception
      print('Error occurred: $e');
      // Show an error dialog to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('please put photo'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }
  }

  Widget filed() => Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.chevron_back,
                      color: color8,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Center(
                    child: Text("pets",
                        style: TextStyle(
                          fontSize: 22,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "name",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(

                      // we return "null" when something is valid

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your name : ",
                      )),
                ],
              ),

              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "status",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      controller: _statusController,
                      readOnly: true,
                      
                      decoration: decorationTextfield.copyWith(
                        prefixIcon: DropdownButton<String>(
                          items: status.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: () {
                                setState(() {
                                  _statusController.text = value;
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _statusController.text = newValue!;
                              if (newValue == "sale") {
                                _isSale =
                                    true; // Set _isSale to true if "sale" status is selected
                              } else {
                                _isSale = false;
                              }
                            });
                          },
                        ),
                      ))
                ],
              ),

              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Type",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    controller: _typeController,
                    readOnly: true,
                    decoration: decorationTextfield.copyWith(
                      prefixIcon: DropdownButton<String>(
                        items: type.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                            onTap: () {
                              setState(() {
                                _typeController.text = value;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                    ),
                  ),
                ],
              ),
              _isSale
                  ? Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(

                            // we return "null" when something is valid

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _PriceController,
                            keyboardType: TextInputType.number,
                            decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your price : ",
                            )),
                      ],
                    )
                  : const SizedBox(
                      height: 5,
                    ),

              const Text(
                "Gender",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                controller: _GenderController,
                readOnly: true,
                decoration: decorationTextfield.copyWith(
                  prefixIcon: DropdownButton<String>(
                    items: Gender.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                        onTap: () {
                          setState(() {
                            _GenderController.text = value;
                          });
                        },
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
              const Text(
                "Location",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                controller: _LocationController,
                readOnly: true,
                decoration: decorationTextfield.copyWith(
                  prefixIcon: DropdownButton<String>(
                    items: Location.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                        onTap: () {
                          setState(() {
                            _LocationController.text = value;
                          });
                        },
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(

                  // we return "null" when something is valid

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _DescriptionController,
                  keyboardType: TextInputType.text,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Description : ",
                  )),
              const SizedBox(
                height: 18,
              ),
              // ignore: sized_box_for_whitespace
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 310,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                      

    int myNumber = 0;
  if (_PriceController.text.trim().isNotEmpty) {
    myNumber = int.parse(_PriceController.text);
  }
                        {
                          uploadPost(
                            context: context,
                            name: _nameController.text,
                            description: _DescriptionController.text,
                            status: _statusController.text,
                            gender: _GenderController.text,
                            type: _typeController.text,
                            price: myNumber,
                            city: _LocationController.text,
                            image_url: image_uri,
                          );
                        }
                      },
                      // ignore: sort_child_properties_last
                      child: !_isLoading
                          ? Text(
                              "posted ",
                              style: TextStyle(fontSize: 19),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(color8),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.chevron_back,
                        color: color8,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: Text("pets",
                          style: TextStyle(
                            fontSize: 22,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: _file == null
                      ? InkWell(
                          onTap: () => _getImage(),
                          child: Container(
                            height: 107,
                            width: 350,
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(),
                                ],
                                color: Color.fromARGB(248, 248, 215, 159),
                                borderRadius: BorderRadius.circular(11)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.plus_app,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "Add Photo",
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 107,
                          width: 350,
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(),
                              ],
                              color: Color.fromARGB(248, 248, 215, 159),
                              borderRadius: BorderRadius.circular(11)),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                fit: BoxFit.fill,
                                image: MemoryImage(_bytes!),
                              ))),
                              IconButton(
                                  onPressed: () {
                                    clearImage1();
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 18,
                ),
                // ignore: sized_box_for_whitespace
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 310,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          uploadImage();
                        },
                        // ignore: sort_child_properties_last
                        child: !_isLoading?
                         Text(
                          "Next ",
                          style: TextStyle(fontSize: 19),
                        ):const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(color8),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, file_names, unused_label, sort_child_properties_last, duplicate_ignore, unused_local_variable

