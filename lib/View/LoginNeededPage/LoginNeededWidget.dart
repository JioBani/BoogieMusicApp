import 'package:database_project/Common/LoadingDialog.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/View/LoginPage/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Style/ShadowPalette.dart';


class LoginNeededWidget extends StatelessWidget {
  const LoginNeededWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "로그인이 필요합니다.",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(height: 10.h,),
        Padding(
          padding:EdgeInsets.only(left: 40.w , right: 40.w),
          child: InkWell(
            onTap: () {
              Get.to(LoginPage());
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    ShadowPalette.defaultShadowLight
                  ]
              ),
              child: Center(
                child: Text(
                  "로그인하기",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

