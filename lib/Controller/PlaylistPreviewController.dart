import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:get/get.dart';

class PlaylistPreviewController extends GetxController{

  Playlist playlist;
  Rx<PlaylistExtend?> playlistExtend = Rx(null);

  PlaylistPreviewController({required this.playlist});

  Future<void> fetchData() async {
    MusicApiResponse<PlaylistExtend> musicApiResponse = await MusicService.getPlaylistExtend(playlist.id);
    if(musicApiResponse.isSuccess){
      playlistExtend.value = musicApiResponse.response!;
    }
    else{
      playlistExtend.value = null;
    }
  }
}