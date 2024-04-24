import 'package:database_project/Common/ImageUrls.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AddingMusicAtPlaylistItemWidget.dart';

class AddingMusicDialog extends StatelessWidget {
  const AddingMusicDialog({super.key, required this.addMusicExtend, required this.playlistList});
  final MusicExtend addMusicExtend;
  final List<PlaylistExtend> playlistList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '플레이리스트에 추가',
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color : Colors.black
        ),
      ),
      content: Container(
        height: 300.h,
        width: 300.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r)
        ),
        child: ListView.builder(
          itemCount: playlistList.length,
          itemBuilder: (context , index){
            return AddingMusicAtPlaylistItemWidget(
              playlist: playlistList[index].playlist,
              musicExtend: addMusicExtend,
              dialogContext: context,
              imageUrl: ImageUrls.playlistCoverList[index],
            );
          }
        ),
      )
    );
  }
}
