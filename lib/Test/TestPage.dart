import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/Auth/JwtToken.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Model/SearchResult.dart';
import 'package:database_project/Service/ApiService/ApiService.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:database_project/View/AlbumPage/AlbumPage.dart';
import 'package:database_project/View/CurrentPlayListPage/CurrentPlaylistPage.dart';
import 'package:database_project/View/LoginNeededPage/LoginNeededWidget.dart';
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
                      ApiResponse<bool> response = await LoginService.instance.login('admin2', 'admin2');
                      if(response.isSuccess){
                        StaticLogger.logger.i('로그인 완료');
                      }
                      else{
                        StaticLogger.logger.e('로그인 실패 : ${response.exception!}');
                      }
                    },
                    child: Text(
                      "로그인",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      LoginService.instance.logout();
                    },
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      await LoginService.instance.refreshAccessToken();
                    },
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color : Colors.black
                      ),
                    )
                ),
                TextButton(
                    onPressed: () async {
                      Get.to(Scaffold(
                        body: LoginNeededWidget(),
                      ));
                    },
                    child: Text(
                      "Refresh",
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
