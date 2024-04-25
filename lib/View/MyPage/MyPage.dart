import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Model/User.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/MyPage/LoginWidget.dart';
import 'package:database_project/View/MyPage/ProfileWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapExitWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                ),
                child: DefaultTextStyle(
                  style:  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                  child: GetX<LoginService>(
                    builder: (service) {
                      if(service.loggedIn){
                        return ProfileWidget(user: User(id: 'user-id', name: 'name', role: 'role'));
                      }
                      else{
                        return const LoginWidget();
                      }
                    }
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              const MenuButton(icon: Icons.settings,text: "환경설정",),
              const MenuButton(icon: Icons.library_books_rounded,text: "공지사항",),
              const MenuButton(icon: Icons.report,text: "문의하기",),
              const MenuButton(icon: Icons.code,text: "오픈소스 라이선스",),

            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 28.sp,
                  color: Colors.grey,
                ),
                SizedBox(width: 15.w,),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color : Colors.black,
                        height: 1
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

