
import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
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

class RankingElementWidget extends StatelessWidget {
  const RankingElementWidget({super.key, required this.music , required this.ranking});

  final MusicExtend music;
  final int ranking;

  @override
  Widget build(BuildContext context) {
    Get.put(PlaylistLibraryController());
    return InkWell(
      onTap: (){
        Get.to(MusicPlayPage(music: music,));
      },
      child: Container(
        width: double.infinity,
        height: 75.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                music.music.imageUrl,
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
            SizedBox(
              width: 40.w,
              child: Text(
                ranking.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                    music.music.title,
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
                            addMusic: music.music,
                            playlistList: Get.find<PlaylistLibraryController>().playlistList
                        );
                      }
                  );
                }                //Get.to(AddingMusicAtPlaylistPage(addMusic: music,));
              },
              itemBuilder: (BuildContext buildContext) {
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
