import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/LoadingState.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'ApiService/ApiResponse.dart';
import 'MusicService.dart';

class PlaylistService extends GetxService{
  final RxMap<int,PlaylistExtend> playlistMap = RxMap();

  Rx<LoadingState> loadingState = Rx(LoadingState.beforeLoading);

  @override
  void onInit() {
    LoginService.instance.addOnLoginListener(fetchData);
    LoginService.instance.addOnLogoutListener(resetData);
    super.onInit();
  }

  Future<void> fetchData() async {
    loadingState.value = LoadingState.loading;
    ApiResponse<List<PlaylistExtend>> response =  await MusicService.getPlaylistExtendsByUser();

    if(response.isSuccess){
      loadingState.value = LoadingState.success;

      for (var element in response.response!) {
        playlistMap[element.playlist.id] = element;
      }

      StaticLogger.logger.i("플레이리스트 불러오기 성공");
    }
    else{
      loadingState.value = LoadingState.fail;
      playlistMap.clear();
      StaticLogger.logger.e("플레이리스트 불러오기 실패");
    }
  }

  void resetData(){
    playlistMap.clear();
  }

  Future<String> addPlaylist(String playlistName)async{
    ApiResponse<Playlist> result = await MusicService.createPlaylist(
        CreatePlaylistDto(name: playlistName)
    );

    if(result.isSuccess){
      playlistMap[result.response!.id] = PlaylistExtend(playlist: result.response!, musics: []);
      playlistMap.refresh();
      return "추가 성공";
    }
    else{
      return "추가 실패 : ${result.exception.toString()}";
    }
  }

  Future<String> deletePlaylist(Playlist playlist)async{
    ApiResponse<dynamic> result = await MusicService.deletePlaylist(playlist.id);

    if(result.isSuccess){
      playlistMap.remove(playlist.id);
      playlistMap.refresh();
      return "삭제 성공";
    }
    else{

      return "삭제 실패 : $result";
    }
  }


  Future<String> addMusicAtPlaylist(int playlistId, MusicExtend music , BuildContext context)async{
    ApiResponse<dynamic> response = await MusicService.addMusicAtPlaylist(
        playlistId ,
        music.music.id
    );

    if(response.isSuccess){
      const snackBar = SnackBar(
        content: Text("음악 추가됨"),
        duration: Duration(seconds: 1),
      );

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      ApiResponse<dynamic> playlistRes = await MusicService.getPlaylistExtend(
          playlistId
      );

      if(response.isSuccess){
        playlistMap[playlistId] = playlistRes.response!;
      }
      else{
        const errorSnackBar = SnackBar(
          content: Text("데이터 불러오기 실패"),
          duration: Duration(seconds: 1),
        );

        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        }
      }

      playlistMap.refresh();

      return "추가 성공";
    }
    else{
      final snackBar = SnackBar(
        content: Text("추가 실패 : ${response.exception}"),
        duration: Duration(seconds: 1),
      );

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return "추가 실패 : ${response.exception}";
    }
  }

  Future<String> deleteMusicAtPlaylist(int playlistId, MusicExtend music , BuildContext context)async{
    ApiResponse<dynamic> response = await MusicService.deleteMusicAtPlaylist(
        playlistId ,
        music.music.id
    );

    if(response.isSuccess){


      const snackBar = SnackBar(
        content: Text("음악 삭제됨"),
        duration: Duration(seconds: 1),
      );

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      ApiResponse<dynamic> playlistRes = await MusicService.getPlaylistExtend(
          playlistId
      );

      if(response.isSuccess){
        playlistMap[playlistId] = playlistRes.response!;
      }
      else{
        const errorSnackBar = SnackBar(
          content: Text("데이터 불러오기 실패"),
          duration: Duration(seconds: 1),
        );

        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        }
      }

      playlistMap.refresh();
      return "삭제 성공";
    }
    else{
      final snackBar = SnackBar(
        content: Text("추가 실패 : ${response.exception}"),
        duration: Duration(seconds: 1),
      );

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }


      return "삭제 실패 : ${response.exception}";
    }
  }
}