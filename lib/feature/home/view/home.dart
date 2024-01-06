import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/core/widget/button_icon_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary500,
        title: const Text(
          "Home",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Home")]),
    );
  }
}
