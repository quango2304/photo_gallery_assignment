import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery_assignment/injectable.dart';
import 'package:photo_gallery_assignment/screens/check_auth_screen.dart';
import 'package:photo_gallery_assignment/screens/photo_list_screen.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Photo Gallery',
      home: const CheckAuthScreen(),
    );
  }
}

