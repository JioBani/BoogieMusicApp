import 'package:database_project/Model/Music.dart';
import 'package:database_project/Service/PlayerService.dart';
import 'package:database_project/View/CurrentPlayListPage/CurrentPlaylistPage.dart';
import 'package:database_project/View/MusicPlayPage/MusicPlayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});


  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {

  @override
  Widget build(BuildContext context) {

    return GetX<PlayerService>(
      builder: (service) {
        if(service.nowPlay.value == null){
          return SizedBox();
        }
        else{
          Music music = service.nowPlay.value!.music;
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              height: 65.h,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.network(music.imageUrl)
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        music.title,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Text(
                        'widget.music.artistName',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white60
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(
                    onTap: (){
                      service.stop();
                    },
                    child: Icon(
                      Icons.pause,
                      size: 35.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Icon(
                    Icons.skip_next,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                  IconButton(
                    icon : Icon(
                      Icons.queue_music_rounded,
                      size: 25.sp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(CurrentPlaylistPage());
                    },
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ).asGlass(
              tintColor: Colors.transparent,
            ),
          );
        }
      }
    );
  }
}
