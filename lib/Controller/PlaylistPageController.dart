/*
import 'package:database_project/Common/ApiResponse.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:get/get.dart';

class PlaylistPageController extends GetxController{

  Rx<PlaylistExtend?> playlistExtend = Rx(null);
  int playlistId;

  PlaylistPageController({required this.playlistId});

  Future<void> fetchData() async {
    MusicApiResponse<PlaylistExtend> response = await MusicService.getPlaylistExtend(playlistId);

    if(response.isSuccess){
      playlistExtend.value = response.response!;
    }
    else{
      playlistExtend.value = null;
    }
  }
}*/
