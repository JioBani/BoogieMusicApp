import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistDto.dart';
import 'package:database_project/Model/Playlist/CreatePlaylistSongDto.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PlaylistLibraryController extends GetxController {

    final RxList<Playlist> playlistList = RxList();

    @override void onInit() {
      super.onInit();
      fetchData();
    }

    @override
    void onClose() {
      super.onClose();
    }

    Future<void> fetchData() async {
      MusicApiResponse<List<Playlist>> response =  await MusicService.getPlaylistsByUserId("user01");
      if(response.isSuccess){
        playlistList.value = response.response!;
      }
      else{
        playlistList.value = [];
      }
    }

    Future<String> deletePlaylist(Playlist playlist)async{
      MusicApiResponse<dynamic> result = await MusicService.deletePlaylist(playlist.id);

      if(result.isSuccess){
        playlistList.remove(playlist);

        return "삭제 성공";
      }
      else{

        return "삭제 실패 : $result";
      }
    }

    Future<String> addPlaylist(String playlistName)async{
      MusicApiResponse<dynamic> result = await MusicService.createPlaylist(
        CreatePlaylistDto(name: playlistName, userId: 'user01')
      );

      if(result.isSuccess){
        await fetchData();
        return "추가 성공";
      }
      else{
        return "추가 실패 : ${result.exception.toString()}";
      }
    }

    Future<String> addMusicAtPlaylist(int playlistId, int musicId , BuildContext context)async{
      MusicApiResponse<dynamic> response = await MusicService.addMusicAtPlaylist(
          playlistId ,
          musicId
      );

      if(response.isSuccess){
        await fetchData();

        const snackBar = SnackBar(
          content: Text("음악 추가됨"),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return "추가 성공";
      }
      else{
        final snackBar = SnackBar(
          content: Text("추가 실패 : ${response.exception}"),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return "추가 실패 : ${response.exception}";
      }
    }
}