import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/CurrentPlaylist/CurrentPlaylist.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:get/get.dart';

class CurrentPlaylistService extends GetxService{
  final Rx<CurrentPlaylist?> playlist = Rx(null);
  final RxList<MusicExtend> musics = RxList([]);

  @override void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override

  Future<void> fetchData() async {
    MusicApiResponse<CurrentPlaylist> response = await MusicService.getCurrentPlaylistByUserId("user01");
    if(!response.isSuccess){
      StaticLogger.logger.e(response.exception);
    }
    else{
      musics.value = response.response!.musics;
    }
    playlist.value = response.response!;
  }

  Future<void> addMusic(MusicExtend musicExtend)async{
    MusicApiResponse<dynamic> response = await MusicService.addMusicAtCurrentPlaylist("user01" , musicExtend.music.id);
    if(response.isSuccess){
      playlist.value!.musics.removeWhere((element) => element.music.id == musicExtend.music.id);
      playlist.value?.musics.insert(0 ,musicExtend);
      musics.value = playlist.value!.musics;
      StaticLogger.logger.i("추가 성공");
      musics.refresh();
      playlist.refresh();
    }
    else{
      StaticLogger.logger.e(response.exception);
    }
  }

  Future<void> deleteMusic(int musicId) async {
    MusicApiResponse<dynamic> response = await MusicService.deleteMusicFromCurrentPlaylist("user01", musicId);
    if (response.isSuccess) {
      playlist.value?.musics.removeWhere((music) => music.music.id == musicId);

      musics.removeWhere((music) => music.music.id == musicId);
      musics.refresh();
      playlist.refresh();

      StaticLogger.logger.i("삭제 성공");
    } else {
      StaticLogger.logger.e(response.exception);
    }
  }
}