
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyledInputFieldWidget extends StatelessWidget {
  const StyledInputFieldWidget({
    super.key,
    required this.content,
    required this.controller,
    this.isPassword = false
  });

  final String content;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
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
