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

import '../../models/solid.dart';
import '../../provider/provider.dart';

class Add_postfA extends StatefulWidget {
  Add_postfA({Key? key}) : super(key: key);

  @override
  State<Add_postfA> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Add_postfA> {
  // ignore: unused_field

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void postImage() async {
    // start the loading

    // upload to storage and db
  }

  void uploadPostFA({
    required BuildContext context,
    required String name,
    required String type,
    required String description,
    required int price,
    required String city,
    required String image_url,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      SOLID solid = SOLID(
          description: description,
          name: name,
          type: type,
          image_url: image_url,
          price:price,
          city: city);
      http.Response res = await http.post(
        Uri.parse("$uri/solid/mine"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": 'Bearer ${userProvider.user.token}'
        },
        body: solid.toJson(),
      );
       print(res.body);
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
           
            showSnackBar(context,
                "uploaded");
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
      _PriceController.text = "";
      _DescriptionController.text = "";
      _LocationController.text = "";
      _nameController.text = "";
      _typeController.text = "";
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _LocationController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  List<String> type = [
    "food",
    "accessories",
    
  ];
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
                    width: 35,
                  ),
                  Center(
                    child: Text("accossories and food ",
                        style: TextStyle(
                          fontSize: 20,
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
                height: 5,
              ),

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
                    onChanged: (value) {},
                  ),
                ),
              ),
          
              Column(
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

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _PriceController,
                      keyboardType: TextInputType.number,
                      decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your price : ",
                      )),
                ],
              ),
              SizedBox(
                height: 5,
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
                        uploadPostFA(
                          context: context,
                          name: _nameController.text,
                          type: _typeController.text,
                          description: _DescriptionController.text,
                          price:int.parse(_PriceController.text),
                          city: _LocationController.text,
                          image_url: image_uri,
                        );
                      },
                      // ignore: sort_child_properties_last
                      child: Text(
                        "posted ",
                        style: TextStyle(fontSize: 19),
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
                      width: 35,
                    ),
                    Center(
                      child: Text("accossories and food",
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
                        child:!_isLoading?
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

// // ignore_for_file: unnecessary_new

// import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// import '../constants/constant.dart';
// import '../constants/textfiled.dart';
// import '../utils/utils.dart';

// class Add_postfA extends StatefulWidget {
//   Add_postfA({Key? key}) : super(key: key);

//   @override
//   State<Add_postfA> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<Add_postfA> {
//   // ignore: unused_field
//   Uint8List? _file;

//   bool isLoading = false;
//   _selectImage(BuildContext parentContext) async {
//     return showDialog(
//       context: parentContext,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Create a Post'),
//           children: <Widget>[
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a photo'),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   Uint8List file = await pickImage(ImageSource.camera);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose from Gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         );
//       },
//     );
//   }

//   bool _isLoading = false;
//   String username = '';
//   var userData = {};

//   @override
//   void initState() {
//     super.initState();
//   }

//   void clearImage() {
//     setState(() {
//       _file = null;
//       _statusController.text = "";
//       _typeController.text = "";
//       _PriceController.text = "";
//       _DescriptionController.text = "";
//       _GenderController.text = "";
//       _LocationController.text = "";
//     });
//   }

//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _statusController = TextEditingController();
//   TextEditingController _typeController = TextEditingController();
//   TextEditingController _PriceController = TextEditingController();
//   TextEditingController _GenderController = TextEditingController();
//   TextEditingController _LocationController = TextEditingController();
//   TextEditingController _DescriptionController = TextEditingController();
//   List<String> status = ["adopt", "sale", "founded", "losted"];
  
//   List<String> Gender = ["Female", "Male"];
//   List<String> Location = [
//     'Cairo ',
//     '10th of Ramadan',
//     '6th of October',
//     'fayoum',
//     'Ismailia',
//     'Suez',
//     'Port Said',
//     'Giza',
//     'Asyut',
//     'Aswan',
//     'Alexandria '
//   ];

//   void dispose() {
//     super.dispose();
//     _DescriptionController.dispose();
//     _LocationController.dispose();
//     _PriceController.dispose();
//     _typeController.dispose();
//     _statusController.dispose();
//     _GenderController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(22.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       CupertinoIcons.chevron_back,
//                       color: color8,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Center(
//                     child: Text("food*accessories",
//                         style: TextStyle(
//                           fontSize: 22,
//                         )),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Center(
//                 child: _file == null
//                     ? InkWell(
//                         onTap: () => _selectImage(context),
//                         child: Container(
//                           height: 107,
//                           width: 350,
//                           padding: EdgeInsets.all(11),
//                           decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(),
//                               ],
//                               color: Color.fromARGB(248, 248, 215, 159),
//                               borderRadius: BorderRadius.circular(11)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 CupertinoIcons.plus_app,
//                               ),
//                               SizedBox(
//                                 width: 50,
//                               ),
//                               Text(
//                                 "Add Photo",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 107,
//                         width: 350,
//                         padding: EdgeInsets.all(11),
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(),
//                             ],
//                             color: Color.fromARGB(248, 248, 215, 159),
//                             borderRadius: BorderRadius.circular(11)),
//                         child: Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                           fit: BoxFit.fill,
//                           image: MemoryImage(_file!),
//                         ))),
//                       ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               const Text(
//                 "Price",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               TextFormField(

//                   // we return "null" when something is valid

//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   controller: _PriceController,
//                   keyboardType: TextInputType.number,
//                   decoration: decorationTextfield.copyWith(
//                     hintText: "Enter Your price : ",
//                   )),

//               const Text(
//                 "Location",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               TextFormField(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 keyboardType: TextInputType.text,
//                 controller: _LocationController,
//                 readOnly: true,
//                 validator: (value) {},
//                 decoration: decorationTextfield.copyWith(
//                   prefixIcon: DropdownButton<String>(
//                     items: Location.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: new Text(value),
//                         onTap: () {
//                           setState(() {
//                             _LocationController.text = value;
//                           });
//                         },
//                       );
//                     }).toList(),
//                     onChanged: (value) {},
//                   ),
//                 ),
//               ),
//               const Text(
//                 "Description",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               TextFormField(

//                   // we return "null" when something is valid

//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   controller: _DescriptionController,
//                   keyboardType: TextInputType.text,
//                   decoration: decorationTextfield.copyWith(
//                     hintText: "Enter Your Description : ",
//                   )),
//               const SizedBox(
//                 height: 18,
//               ),
//               // ignore: sized_box_for_whitespace
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Container(
//                     width: 310,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () async {},
//                       // ignore: sort_child_properties_last
//                       child: isLoading
//                           ? CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               "Next ",
//                               style: TextStyle(fontSize: 19),
//                             ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(color8),
//                         padding:
//                             MaterialStateProperty.all(EdgeInsets.all(12)),
//                         shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8))),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, file_names, unused_label, sort_child_properties_last, duplicate_ignore, unused_local_variable

// ignore_for_file: unnecessary_new