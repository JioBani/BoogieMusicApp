import 'package:database_project/Common/DubleTapExitWidget.dart';
import 'package:database_project/Common/LoadingDialog.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:database_project/View/Common/StyledInputFieldWidget.dart';
import 'package:database_project/View/RegistrationPage/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});


  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              SizedBox(height: 90.h,),
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
              SizedBox(height: 40.h,),
              Padding(
                padding: EdgeInsets.fromLTRB(30.w, 0 , 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "로그인 해서 부기뮤직의 다양한 \n서비스를 이용해 보세요.",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              StyledInputFieldWidget(content: "아이디", controller: idController,),
              SizedBox(height: 20.h,),
              StyledInputFieldWidget(content: "비밀번호", controller: passwordController, isPassword: true,),
              SizedBox(height: 20.h,),
              Padding(
                padding:EdgeInsets.only(left: 20.w , right: 20.w),
                child: InkWell(
                  onTap: () async {
                    final (result , isClosed) = await LoadingDialog.showLoadingDialogWithFuture(
                        context,
                        LoginService.instance.login(idController.text, passwordController.text)
                    );
        
                    if(!result.isSuccess){
                      Fluttertoast.showToast(msg: "로그인에 실패했습니다. : ${result.exception}");
                    }
                    else{
                      Fluttertoast.showToast(msg: "로그인에 성공했습니다.");
                      if(context.mounted){
                        Get.back();
                      }
                    }
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
              SizedBox(height: 10.h,),
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
                        onPressed: (){
                          Get.to(RegistrationPage());
                        },
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
            ],
          )
        ),
      ),
    );
  }
}


