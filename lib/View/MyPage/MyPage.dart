import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Test/TestPage.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:database_project/View/LoginPage/LoginPage.dart';
import 'package:database_project/View/RegistrationPage/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapExitWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              DefaultTextStyle(
                style: TextStyle(
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                  child: DefaultTextStyle(
                    style:  TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "로그인하세요",
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                Get.to(LoginPage());
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                size : 30.sp,
                                color: Colors.white,
                              )
                            )
                          ],
                        ),
                        SizedBox(height: 50.h,),
                        Text(
                          "로그인 해서 뮤직 플레이어의\n서비스를 이용해보세요.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 50,),
                        TextButton(
                          onPressed: (){
                            Get.to(RegistrationPage());
                          },
                          child: Text(
                            "회원가입하기",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color : Colors.white
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    Get.to(TestPage());
                  },
                  child: Text(
                    "테스트 페이지",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color : Colors.black
                    ),
                  )
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
