// ignore_for_file: unused_local_variable, unused_field

import 'package:aliifa/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constant.dart';
import '../constants/err_handling.dart';
import '../constants/snackbar.dart';
import '../constants/textfiled.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isvalid = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _PhoneController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _genderController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  Uint8List? imgPath;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
  }

  void clearImage() {
    setState(() {
      _addressController.text = "";
      _nameController.text = "";
      _passwordController.text = "";
      _emailController.text = "";
      _PhoneController.text = "";
    });
  }

  void signUpUserr({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String city,
    required String Phone,
  }) async {
    setState(() {
      _isLoading = true;
    });
    //
    try {
      final user = UserModel(
        name: name,
        email: email,
        password: password,
        password_confirm: password,
        city: city,
        phone: Phone,
        image_url: "image_url",
        country: "country",
      );

      http.Response res = await http.post(
        Uri.parse("$uri/user/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            setState(() {
              _isLoading = false;
            }); setState(() {
              isvalid = true;
            });
            showSnackBar(context,
                "Your account has been created successfully.please sgin_in");
            clearImage();
          });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(33.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: _nameController,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your username : ",
                        suffixIcon: Icon(Icons.person))),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  controller: _addressController,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your address : ",
                    suffixIcon: Icon(
                      CupertinoIcons.location_solid,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    // we return "null" when something is valid
                    validator: !isvalid?(value) {
                      return value!
                              .contains(RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)'))
                          ? null
                          : "Enter a valid phone";
                    }:(value) {
                    return;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _PhoneController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your phone : ",
                        suffixIcon: Icon(Icons.call))),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    // we return "null" when something is valid
                    validator: !isvalid?(email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    }:(value) {
                    return;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: Icon(Icons.email))),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(

                    // we return "null" when something is valid
                    validator:!isvalid? (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    }:(value) {
                    return;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Enter Your Password : ",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)))),
                const SizedBox(
                  height: 23,
                ),
                const SizedBox(
                  height: 23,
                ),
                InkWell(
                    child: Container(
                      child: !_isLoading
                          ? const Text('Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ))
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        color: color8,
                      ),
                    ),
                    onTap: () {
           
                      if (
                        
                        _formKey.currentState!.validate()) {
                                      setState(() {
              isvalid = false;
            });
                        signUpUserr(
                            city: _addressController.text,
                            context: context,
                            email: _emailController.text,
                            name: _nameController.text,
                            password: _passwordController.text,
                            Phone: _PhoneController.text);
                      }
                    }),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 27),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48,
                              width: 48,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      // color: Colors.purple,

                                      width: 1)),
                              child: SvgPicture.asset(
                                "asset/icons/mm.svg",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 85,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 27),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 48,
                              width: 48,
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      // color: Colors.purple,

                                      width: 1)),
                              child: SvgPicture.asset(
                                "asset/icons/Vector (4).svg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
