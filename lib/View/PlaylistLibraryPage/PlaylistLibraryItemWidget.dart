import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Controller/PlaylistPreviewController.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:database_project/Style/ShadowPalette.dart';
import 'package:database_project/View/PlayListPage/PlayListPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../MusicElementWidget.dart';

enum MenuType {
  remove
}



class PlaylistLibraryItemWidget extends StatefulWidget {
  PlaylistLibraryItemWidget({
    super.key,
    required this.currentIndex,
    required this.index,
    required this.playlistExtend,
    required this.pageController,
    required this.imageUrl
  });

  final int currentIndex;
  final int index;
  final PlaylistExtend playlistExtend;
  final PageController pageController;
  final String imageUrl;

  @override
  State<PlaylistLibraryItemWidget> createState() => _PlaylistLibraryItemWidgetState();
}

class _PlaylistLibraryItemWidgetState extends State<PlaylistLibraryItemWidget> {

  @override
  void initState() {
    var controller = Get.put(PlaylistPreviewController(
        playlist: widget.playlistExtend.playlist),
        tag: widget.playlistExtend.playlist.id.toString()
    );
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var _scale = widget.currentIndex == widget.index ? 1.0 : 0.8;

    return TweenAnimationBuilder(
        tween: Tween(begin: _scale, end: _scale),
        duration: const Duration(milliseconds: 350),
        child: InkWell(
          onTap: (){
            Get.to(PlayListPage(playlistExtend: widget.playlistExtend));
          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [ShadowPalette.defaultShadowLight]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        width: 500.w,
                        height: 500.w,
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 0, 20.w),
                            child: Text(
                              widget.playlistExtend.playlist.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30.sp,
                                  color: Colors.white
                              ),
                            ),
                          )
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 15.w, 15.w),
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                ShadowPalette.defaultShadowLight,
                              ]
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 32.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.w, top: 8.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<MenuType>(
                            color: Colors.white,
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 32.sp,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.r))
                            ),
                            itemBuilder: (BuildContext buildContext) {
                              return [
                                for (final value in MenuType.values)
                                  PopupMenuItem(
                                    value: value,
                                    onTap: () async {
                                      String result = await Get.find<PlaylistService>().deletePlaylist(widget.playlistExtend.playlist);
                                      final snackBar = SnackBar(
                                        content: Text(result),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      if(result == "삭제 성공"){
                                        widget.pageController.animateToPage(
                                            widget.index - 1 == -1 ? 0 : widget.index - 1,
                                            duration: Duration(milliseconds: 700),
                                            curve: Curves.linearToEaseOut
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        "삭제",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp
                                        ),
                                      )
                                    ),
                                    height: 25.h,
                                  ),
                              ];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h,),
                Expanded(
                  child: GetX<PlaylistService>(
                    builder: (service) {
                      List<Widget> preview = [];
                      List<MusicExtend> musicExtends = service.playlistMap[widget.playlistExtend.playlist.id]?.musics ?? [];

                      for(int i = 0; i<musicExtends.length && i <  3; i++ ){
                        preview.add(MusicElementWidget(
                          musicExtend: musicExtends[i],
                        ));
                      }
                      for (var music in musicExtends) {

                      }

                      preview.add(const Expanded(child: SizedBox()));

                      preview.add(
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 32.sp,
                              ),
                            ),
                          )
                      );

                      return Column(
                        children: preview,
                      );
                    }
                  ),
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
}
