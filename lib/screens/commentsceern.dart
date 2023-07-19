// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants/textfiled.dart';

// ignore: must_be_immutable
class CommentScreen extends StatefulWidget {
  // data of clicked post

  bool showTextField = true;
  CommentScreen({Key? key, required this.showTextField}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentsScreenState();
}

var userData = {};
bool _isLoading = false;

class _CommentsScreenState extends State<CommentScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();

    super.dispose();
  }

  void clearcomment() {
    setState(() {
      commentController.text = "";
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://glenfarrow.co.uk/wp-content/uploads/User-icon-413x413.png",
                          ),
                          radius: 18,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                        text: "",
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text("")),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.favorite,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.showTextField
                ? Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(125, 78, 91, 110),
                          ),
                          child: CircleAvatar(
                            backgroundImage: null,
                            radius: 26,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                              controller: commentController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              decoration: decorationTextfield.copyWith(
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.send)))),
                        ),
                      ],
                    ),
                  )
                : Text("")
          ],
        ),
      ],
    );
  }
}
