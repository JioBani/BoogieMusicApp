import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
            SizedBox(height: 50.h,),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 0 , 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "회원가입",
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            CustomInputFieldWidget(content: "이름",),
            SizedBox(height: 20.h,),
            CustomInputFieldWidget(content: "아이디",),
            SizedBox(height: 20.h,),
            CustomInputFieldWidget(content: "비빌번호",),
            SizedBox(height: 20.h,),
            CustomInputFieldWidget(content: "비밀번호 확인",),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 0 , 0, 0),
              child: Row(
                children: [
                  Text(
                    "아이디가 있으신가요?",
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
                        "로그인",
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
                      "회원가입하기",
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

class GenderSelectWidget extends StatefulWidget {
  const GenderSelectWidget({super.key});

  @override
  State<GenderSelectWidget> createState() => _GenderSelectWidgetState();
}

class _GenderSelectWidgetState extends State<GenderSelectWidget> {
  String? selectedGender;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "성별" ,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp
            ),
          ),
        ),
        genderRadioListTile('남자'),
        genderRadioListTile('여자'),
        genderRadioListTile('기타'),
      ],
    );
  }

  Widget genderRadioListTile(String value) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(
            value,
          style: TextStyle(
            fontSize: 12.sp
          ),
        ),
        value: value,
        groupValue: selectedGender,
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
          });
        },
      ),
    );
  }
}


