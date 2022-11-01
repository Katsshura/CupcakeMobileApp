import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar build(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title),
      centerTitle: true,
    );
  }

}