import 'package:flutter/material.dart';
// ignore_for_file: file_names

Widget basicAppBar(BuildContext context, String title) {
  return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColorDark,
      title: Text(title));
}
