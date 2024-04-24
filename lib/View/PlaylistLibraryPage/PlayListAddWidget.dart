import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PlayListAddWidget extends StatelessWidget {
  const PlayListAddWidget({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.pageController,
  });

  final int currentIndex;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    var _scale = currentIndex == index ? 1.0 : 0.8;
   // PlaylistLibraryItemData itemData = playListLibraryItemList[index];
    return TweenAnimationBuilder(
        tween: Tween(begin: _scale, end: _scale),
        duration: const Duration(milliseconds: 350),
        child: InkWell(
          onTap: () async {

            _showInputDialog(context);

          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        width: 500.w,
                        height: 500.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.blueGrey
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 0, 20.w),
                            child: Text(
                              "추가",
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
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        });
  }

  void _showInputDialog(BuildContext context) {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('플레이리스트 만들기'),

          content: TextField(
            decoration: InputDecoration(labelText: '플레이리스트 이름'),
            controller: textController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                String result = await Get.find<PlaylistService>().addPlaylist(textController.text);

                Fluttertoast.showToast(msg: result);
                if(result == "추가 성공"){
                  pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.linearToEaseOut
                  );
                }
              },
              child: Text('만들기'),
            ),
          ],
        );
      },
    );
  }
}
