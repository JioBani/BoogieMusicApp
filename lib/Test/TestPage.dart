import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Model/SearchResult.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:database_project/View/AlbumPage/AlbumPage.dart';
import 'package:database_project/View/CurrentPlayListPage/CurrentPlaylistPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Model/Playlist/Playlist.dart';


class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<SearchResult> searchResult = await MusicService.search("d");
                      if(searchResult.isSuccess){
                        print(searchResult.response!.songsResult);
                        //print(searchResult.albumsResult);
                        //print(searchResult.artistsResult);

                      }
                    },
                    child: Text(
                      "검색",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      //String result = await MusicService.addMusicAtPlaylist(4 , 1);
                      //print(result);
                    },
                    child: Text(
                      "플레이리스트에 음악 추가",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      Get.to(CurrentPlaylistPage());
                    },
                    child: Text(
                      "현재 플레이리스트",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<List<Playlist>> response = await MusicService.getPlaylistsByUserId('user01');
                      if(response.isSuccess){
                        for (var element in response.response!) {
                          StaticLogger.logger.i(element.toMap());
                        }
                      }
                      else{
                        StaticLogger.logger.e(response.exception);
                      }
                    },
                    child: Text(
                      "플레이리스트 목록 가져오기",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<PlaylistExtend> response = await MusicService.getPlaylistExtend(1);
                      if(response.isSuccess){
                        StaticLogger.logger.i(response.response!.toMap());
                      }
                      else{
                        StaticLogger.logger.e(response.exception);
                      }
                    },
                    child: Text(
                      "플레이리스트 가져오기",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<dynamic> response = await MusicService.createPlaylist(
                        CreatePlaylistDto(name: 'name', userId: 'user01')
                      );
                      if(response.isSuccess){
                        for (var element in response.response!) {
                          StaticLogger.logger.i(element.toMap());
                        }
                      }
                      else{
                        StaticLogger.logger.e(response.exception);
                      }

                    },
                    child: Text(
                      "플레이리스트 만들기",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<dynamic> response = await MusicService.updatePlaylist(
                        9,
                        CreatePlaylistDto(name: 'name2', userId: 'user01')
                      );
                      if(response.isSuccess){
                        StaticLogger.logger.i(response.response);
                      }
                      else{
                        StaticLogger.logger.e(response.exception);
                      }

                    },
                    child: Text(
                      "플레이리스트 변경",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      MusicApiResponse<dynamic> response = await MusicService.deletePlaylist(
                          9,
                      );
                      if(response.isSuccess){
                        StaticLogger.logger.i(response.response);
                      }
                      else{
                        StaticLogger.logger.e(response.exception);
                      }

                    },
                    child: Text(
                      "플레이리스트 삭제",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      //Get.to(AlbumPage());
                    },
                    child: Text(
                      "앨범페이지",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}
