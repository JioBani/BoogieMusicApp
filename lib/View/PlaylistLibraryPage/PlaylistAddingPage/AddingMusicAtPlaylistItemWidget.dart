import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class AddingMusicAtPlaylistItemWidget extends StatefulWidget {
  const AddingMusicAtPlaylistItemWidget({
    super.key,
    required this.playlist,
    required this.musicExtend,
    required this.dialogContext,
    required this.imageUrl
  });

  final Playlist playlist;
  final MusicExtend musicExtend;
  final BuildContext dialogContext;
  final String imageUrl;

  @override
  State<AddingMusicAtPlaylistItemWidget> createState() => _AddingMusicAtPlaylistItemWidgetState();
}

class _AddingMusicAtPlaylistItemWidgetState extends State<AddingMusicAtPlaylistItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.pop(widget.dialogContext);
        await Get.find<PlaylistService>().addMusicAtPlaylist(widget.playlist.id, widget.musicExtend, context);
      },
      child: Container(
        width: double.infinity,
        height: 75.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fill,
                width: 60.h,
                height: 60.h,
              ),
            ),
            SizedBox(width: 20.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.playlist.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
