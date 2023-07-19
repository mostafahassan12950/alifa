// ignore_for_file: unused_local_variable, unused_field


import 'package:aliifa/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constant.dart';
import '../constants/err_handling.dart';
import '../constants/snackbar.dart';
import '../constants/textfiled.dart';
import '../provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _RegisterState();
}

class _RegisterState extends State<EditProfile> {
  bool isVisable = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.user.name;
    _emailController.text = userProvider.user.email;
    _addressController.text = userProvider.user.city;
    _phoneController.text = userProvider.user.phone!;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
  }

  void clearImage() {
    setState(() {
      _addressController.text = "";
      _nameController.text = "";
      _passwordController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
    });
  }

  void UpdetUserrr({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String city,
    required String phone,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    //
    try {
      final user = UserModel(
        name: name.isNotEmpty ? name : userProvider.user.name.toString(),
        email:
            email.isNotEmpty ? email : userProvider.user.email.toString(),
        password: password.isNotEmpty
            ? password
            : userProvider.user.password.toString(),
        password_confirm: password.isNotEmpty
            ? password
            : userProvider.user.password_confirm.toString(),
        city: city.isNotEmpty ? city : userProvider.user.city.toString(),
        image_url: "image_url",
        country: "country",
        phone: phone.isNotEmpty ? phone : userProvider.user.phone.toString(),
        id: userProvider.user.id.toString(),
        role: userProvider.user.role,
      );

      http.Response res = await http.patch(
        Uri.parse("$uri/user/${userProvider.user.id}"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": 'Bearer ${userProvider.user.token}'
        },
      );
      print(res.body);
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            setState(() {
            // Update value from _nameController
            // Update value from _phoneController
              _isLoading = false;
            });

            showSnackBar(context, "Your Edited  successfully.");

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
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
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: decorationTextfield.copyWith(
                        hintText: "Name",
                        suffixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Phone",
                      suffixIcon: Icon(
                        Icons.call,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                 ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Address",
                      suffixIcon: Icon(
                        CupertinoIcons.location_solid,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Email",
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "New Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  InkWell(
                    child: Container(
                      child: !_isLoading
                          ? const Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: color8,
                      ),
                    ),
                    onTap: () {
                          

                      UpdetUserrr(
                        phone: _phoneController.text,
                        city: _addressController.text,
                        context: context,
                        email: _emailController.text,
                        name: _nameController.text,
                        password: _passwordController.text,
                      );
            
                    },

                    
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}