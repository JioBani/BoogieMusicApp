import 'package:database_project/View/LoginPage/LoginPage.dart';
import 'package:database_project/View/RegistrationPage/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
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
            SizedBox(height: 30.h,),
            Text(
              "로그인 해서 뮤직 플레이어의\n서비스를 이용해보세요.",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
                onPressed: (){
                  Get.to(RegistrationPage());
                },
                child: Text(
                  "회원가입하기",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color : Colors.white
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
