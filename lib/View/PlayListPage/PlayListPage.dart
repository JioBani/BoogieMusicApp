import 'package:database_project/Controller/PlaylistPageController.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/LoadingState.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:database_project/View/BottomNavBar/BottomNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../MusicElementWidget.dart';


const String tempImage = "https://ibighit.com/bts/images/bts/discography/butter/butter-cover.jpg";
const String orangeImage = "https://ibighit.com/bts/images/bts/discography/butter-2/butter-2-cover.jpg";
const String newj = "https://marketplace.canva.com/EAExV_SCzfw/1/0/1600w/canva-%EC%B2%AD%EB%A1%9D%EC%83%89-%ED%95%98%EB%8A%98-%EB%B0%B0%EA%B2%BD-%EC%95%84%EC%9D%B4%EC%8A%A4%ED%81%AC%EB%A6%BC-%EC%82%AC%EC%A7%84-%EC%95%A8%EB%B2%94%EC%BB%A4%EB%B2%84-GwDEFZt-cps.jpg";
const String evan = "https://i1.sndcdn.com/artworks-000156787653-tqesbb-t500x500.jpg";

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key, required this.playlistExtend});

  final PlaylistExtend playlistExtend;

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h,),
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.playlistExtend.playlist.name,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                padding: EdgeInsets.fromLTRB(15.w, 0, 10.w, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r) , topRight: Radius.circular(30.r)),
                  //color: Color(0xffEBC7E4)
                ),
                child: GetX<PlaylistService>(
                  builder: (service) {
                    List<MusicExtend> musicExtends = service.playlistMap[widget.playlistExtend.playlist.id]!.musics;
                    return ListView.builder(
                        itemCount:  musicExtends.length,
                        itemBuilder: (context , index){
                          return MusicElementWidget(
                            musicExtend: musicExtends[index],
                            playlistId: widget.playlistExtend.playlist.id,
                          );
                        }
                    );
                  }
                ),
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}