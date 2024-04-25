import 'package:database_project/Model/User.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Style/Images.dart';
import 'package:database_project/View/RegistrationPage/RegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
      child: DefaultTextStyle(
        style:  TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.asset(
                          Images.profileImage,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.name} 님",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          user.role,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                      ],
                    ),
                  ],
                ),

              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: (){
                  LoginService.instance.logout();
                },
                child: Text(
                  "로그아웃하기 >",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
