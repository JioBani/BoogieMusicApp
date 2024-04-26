import 'package:database_project/Common/LoadingDialog.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/User.dart';
import 'package:database_project/Model/User/CreateUserDto.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:database_project/View/Common/StyledInputFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordReController = TextEditingController();


  Future<bool?> buildSuccessDialog(BuildContext context, String msg) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Center(
              child: Text(
                msg,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp
                ),
              ),
            ),
            actionsPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: Colors.black
                ),
                child: Text(
                  "확인",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      },
    );
  }

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
            StyledInputFieldWidget(content: "아이디",controller: idController,),
            SizedBox(height: 20.h,),
            StyledInputFieldWidget(content: "이름",controller:nameController ,),
            SizedBox(height: 20.h,),
            StyledInputFieldWidget(content: "비빌번호",controller: passwordController,isPassword: true,),
            SizedBox(height: 20.h,),
            StyledInputFieldWidget(content: "비밀번호 확인",controller: passwordReController, isPassword: true,),
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
                onTap: () async {
                  User user = User(
                      id: idController.text,
                      name: nameController.text,
                      role: ""
                  );

                  CreateUserDto createUserDto = CreateUserDto(
                      id: idController.text,
                      name: nameController.text,
                      password: passwordController.text
                  );


                  var (result , msg) = createUserDto.checkValidate();

                  if(!result){
                    Fluttertoast.showToast(msg: msg);
                    return;
                  }

                  if(passwordController.text != passwordReController.text){
                    Fluttertoast.showToast(msg: "비밀번호 확인이 다릅니다.");
                    StaticLogger.logger.i("${passwordController.text} ,  ${passwordReController.text}");
                    return;
                  }

                  final (signInRes , isClosed) = await LoadingDialog.showLoadingDialogWithFuture(
                      context,
                      LoginService.instance.signIn(createUserDto)
                  );

                  if(!signInRes.isSuccess){
                    buildSuccessDialog(context, "${signInRes.exception}");
                  }
                  else{
                    buildSuccessDialog(context, "회원가입에 성공했습니다.").then(
                        (value) => {
                          if(context.mounted){
                            Navigator.of(context).pop()
                          }
                        }
                    );
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