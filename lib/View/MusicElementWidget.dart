import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Service/CurrentPlaylistService.dart';
import 'package:database_project/View/MusicPlayPage/MusicPlayPage.dart';
import 'package:database_project/View/PlaylistLibraryPage/PlaylistAddingPage/AddingMusicDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
const String tempImage = "https://ibighit.com/bts/images/bts/discography/butter/butter-cover.jpg";

enum MenuType{
  add,
  remove,
}

class MusicElementWidget extends StatelessWidget {
  const MusicElementWidget({super.key, required this.musicExtend, this.isInPlaylist, this.isInCurrentPlaylist = false});

  final MusicExtend musicExtend;
  final int? isInPlaylist;
  final bool isInCurrentPlaylist;

  @override
  Widget build(BuildContext context) {
    Get.put(PlaylistLibraryController());
    var currentPlaylistService = Get.find<CurrentPlaylistService>();
    return InkWell(
      onTap: (){
        Get.to(MusicPlayPage(music: musicExtend,));
      },
      child: Container(
        width: double.infinity,
        height: 75.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                musicExtend.music.imageUrl,
                fit: BoxFit.fill,
                width: 60.h,
                height: 60.h,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 20.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "music.albumTitle",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp,
                    color: Colors.black54,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 1.h,),
                SizedBox(
                  width: 145.w,
                  child: Text(
                    musicExtend.music.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 3.h,),
                Text(
                 "music.artistName",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.black54,
                      overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            PopupMenuButton<MenuType>(
              color: Colors.white,
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 25.sp,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.r))
              ),
              onSelected: (MenuType result){
                if(result == MenuType.add){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AddingMusicDialog(
                            addMusic: musicExtend.music,
                            playlistList: Get.find<PlaylistLibraryController>().playlistList
                        );
                      }
                  );
                }                //Get.to(AddingMusicAtPlaylistPage(addMusic: music,));
              },
              itemBuilder: (BuildContext buildContext) {
                if(isInPlaylist != null || isInCurrentPlaylist){
                  return [
                    PopupMenuItem(
                      value: MenuType.add,
                      child: Text(
                        "플레이리스트에 추가",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp
                        ),
                      ),
                      height: 32.h,
                    ),
                    PopupMenuItem(
                      value: MenuType.remove,
                      onTap : (){
                        if(isInCurrentPlaylist){
                          currentPlaylistService.deleteMusic( musicExtend.music.id);
                        }
                      },
                      child: Text(
                        "플레이리스트에서 제거",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp
                        ),
                      ),
                      height: 32.h,
                    )
                  ];
                }
                else{
                  return [
                    PopupMenuItem(
                      value: MenuType.add,
                      child: Text(
                        "플레이리스트에 추가",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp
                        ),
                      ),
                      height: 32.h,
                    )
                  ];
                }
              },
              elevation: 4,
            ),
            SizedBox(width: 5.w,)
          ],
        ),
      ),
    );
  }
}
