import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "추천 장르",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp,
                ),
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenrePanelWidget(imageUrl: ImageUrls.indie,name: "indie",),
              GenrePanelWidget(imageUrl: ImageUrls.elec,name: "punk",),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GenrePanelWidget(imageUrl: ImageUrls.pop,name: "pop"),
              GenrePanelWidget(imageUrl: ImageUrls.randb,name: "R & B"),
            ],
          )
        ],
      ),
    );
  }
}

class GenrePanelWidget extends StatelessWidget {
  const GenrePanelWidget({super.key, required this.imageUrl, required this.name});

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Material(
          elevation: 1,
          child: Container(
            height: 120.h,
            width: 180.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 120.h,
                    width: 180.h,  
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 10.h),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

