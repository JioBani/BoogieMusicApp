import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w , top: 10.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 30.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.h,),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 0 , 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "로그인",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            CustomInputFieldWidget(content: "아이디",),
            SizedBox(height: 20.h,),
            CustomInputFieldWidget(content: "비밀번호",),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 0 , 0, 0),
              child: Row(
                children: [
                  Text(
                    "아이디가 없으신가요?",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                      ),
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding:EdgeInsets.only(left: 20.w , right: 20.w),
              child: InkWell(
                onTap: (){

                },
                child: Container(
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
        ),
      ),
    );
  }
}

class CustomInputFieldWidget extends StatelessWidget {
  const CustomInputFieldWidget({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor:  Colors.black12,
              hintText: content,
              contentPadding: EdgeInsets.symmetric(vertical: 20.h , horizontal: 10.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none, // border 없애기
              )
            ),
          ),
        ),
      ],
    );
  }
}


