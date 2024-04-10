import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Controller/PlayerController.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/HomePage/MusicChart.dart';
import 'package:database_project/View/Player/PlayerView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'CustomSearchBar.dart';
import 'Recommended.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DoubleTapExitWidget(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  CustomSearchBar(),
                  Recommended(),
                  SizedBox(height: 15.h,),
                  MusicChart(),
                  SizedBox(height: 60.h,)
                ],
              ),
              PlayerWidget()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
