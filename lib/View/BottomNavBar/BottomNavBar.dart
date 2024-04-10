import 'package:database_project/View/CurrentPlayListPage/CurrentPlaylistPage.dart';
import 'package:database_project/View/HomePage/HomePage.dart';
import 'package:database_project/View/MyPage/MyPage.dart';
import 'package:database_project/View/PlayListPage/PlayListPage.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlaylistLibraryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.infinity,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        //borderRadius: BorderRadius.circular(20.r), // 모든 모서리를 둥글게
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,-2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1)
          )
        ]// : const Color(0xffBBE6F3)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Get.offAll(
                HomePage(),
                transition: Transition.cupertino
              );
            },
            icon: Center(
              child: SvgPicture.asset(
                "assets/images/home.svg",
                width: 35.sp,
                height: 35.sp,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Get.offAll(
                PlayListLibraryPage(),
                transition: Transition.cupertino
              );
            },
            icon: Center(
              child: SvgPicture.asset(
                "assets/images/playlist.svg",
                width: 35.sp,
                height: 35.sp,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Get.offAll(
                CurrentPlaylistPage(),
                transition: Transition.cupertino
              );
            },
            icon: Center(
              child: SvgPicture.asset(
                "assets/images/profile.svg",
                width: 35.sp,
                height: 35.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
