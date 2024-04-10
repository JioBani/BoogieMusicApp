import 'package:database_project/Controller/PlaylistLibraryController.dart';
import 'package:database_project/Model/Album.dart';
import 'package:database_project/Model/AlbumExtend.dart';
import 'package:database_project/Model/Artist.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/View/ArtistPage/ArtistPage.dart';
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

class ArtistElementWidget extends StatelessWidget {
  const ArtistElementWidget({super.key, required this.artist, this.isInPlaylist = false});

  final Artist artist;
  final bool isInPlaylist;

  @override
  Widget build(BuildContext context) {
    Get.put(PlaylistLibraryController());
    return InkWell(
      onTap: (){
        Get.to(ArtistPage(artist: artist,));
      },
      child: Container(
        width: double.infinity,
        height: 75.h,
        child: Row(
          children: [
            SizedBox(
              width: 60.h,
              height: 60.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  "Images",
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
            ),
            SizedBox(width: 20.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 145.w,
                  child: Text(
                    artist.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: 3.h,),
              ],
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
