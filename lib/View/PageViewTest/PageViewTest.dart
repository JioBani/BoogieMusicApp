/*
import 'package:card_swiper/card_swiper.dart';
import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Model/PlaylistLibraryItemData.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:database_project/View/HomePage/CustomSearchBar.dart';
import 'package:database_project/View/HomePage/MusicChart.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlaylistLibraryItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({super.key, required this.playlistLibraryItemData});

  final PlaylistLibraryItemData playlistLibraryItemData;

  @override
  State<PageViewTest> createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40.h,),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Playlist",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 34.sp
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h,),
            Container(
                height: 300.w,
                child: Swiper(
                  loop: false,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    return SizedBox(
                      height: 300.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Image.network(
                                    ImageUrls.playlistCover02,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20.w, 0, 0, 20.w),
                                    child: Text(
                                        "팝송",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 30.sp,
                                          color: Colors.white
                                        ),
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                PlaylistLibraryItemWidget(),
                                PlaylistLibraryItemWidget(),
                                PlaylistLibraryItemWidget(),
                                PlaylistLibraryItemWidget(),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  viewportFraction: 0.6,
                  scale: 0.65,
                  index: 1,
                  itemHeight: 300.w,
                  itemWidth: 300.w,
                  layout: SwiperLayout.DEFAULT,
                )
            ),
          ],
        ),
      ),
    );
  }
}
*/
