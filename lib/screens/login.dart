// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_import, use_build_context_synchronously, depend_on_referenced_packages, unused_local_variable

import 'dart:convert';

import 'package:aliifa/responsive/mobile_screen_layout.dart';
import 'package:aliifa/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant.dart';
import '../constants/err_handling.dart';
import '../constants/snackbar.dart';
import '../provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  InputDecoration decorationTextfield = InputDecoration(
    // To delete borders
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    // fillColor: Colors.red,
    filled: true,
    contentPadding: EdgeInsets.all(8),
  );

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await http.post(
        Uri.parse("$uri/user/login"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res);
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () async {
            setState(() {
              _isLoading = false;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => mobile_screen_layout()),
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'Authorization', jsonDecode(res.body)['token']);
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Welcome Back !",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
                validator: (email) {
                  return email!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter a valid email";
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: decorationTextfield.copyWith(
                  hintText: " Email : ",
                  prefixIcon: Icon(
                    Icons.email,
                    color: color8.withOpacity(.40),
                  ),
                )),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
                validator: (value) {
                  return value!.length < 8
                      ? "Enter at least 8 characters"
                      : null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: isVisable ? false : true,
                decoration: decorationTextfield.copyWith(
                    hintText: " Password :",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: color8.withOpacity(.40),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      icon: isVisable
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      color: color8.withOpacity(.40),
                    ))),
            Row(
              children: [
                const SizedBox(
                  width: 155,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Forgot password",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(
              height: 33,
            ),
            InkWell(
              child: Container(
                width: 310,
                height: 55,
                child: !_isLoading
                    ? const Text('Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ))
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
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
                if (_formKey.currentState!.validate()) {
                  signInUser(
                      context: context,
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
            ),
            const SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 299,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "OR",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Continue with ",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
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
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
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
          ]),
        ),
      ),
    ));
  }
}
