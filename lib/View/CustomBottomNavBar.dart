import 'package:database_project/Controller/CustomBottomNavigationBarController.dart';
import 'package:database_project/View/HomePage/HomePage.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlaylistLibraryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'MyPage/MyPage.dart';
import 'PlayListPage/PlayListPage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  var controller = Get.put(CustomBottomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<CustomBottomNavigationBarController>(
        builder: (controller) {
          return BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: (index){
                controller.onTap(index);
                switch(index){
                  case 0 : Get.off(
                    HomePage(),
                    transition: Transition.noTransition,
                  );
                  case 1 : Get.off(
                    PlayListLibraryPage(),
                    transition: Transition.noTransition,
                  );
                  case 2 : Get.off(
                    MyPage(),
                    transition: Transition.noTransition,
                  );
                  case 3 : Get.off(
                    MyPage(),
                    transition: Transition.noTransition,
                  );
                }
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home ,size: 25.w,),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search, size: 25.w),
                  label: '플레이리스트',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications, size: 25.w),
                  label: '마이페이지',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications, size: 25.w),
                  label: '마이페이지',
                ),
              ]
          );
        }
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String text;

  PlaceholderWidget({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}