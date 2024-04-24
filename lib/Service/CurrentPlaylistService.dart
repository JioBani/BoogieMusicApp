import 'package:database_project/Service/ApiService/ApiResponse.dart';
import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/CurrentPlaylist/CurrentPlaylistDto.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Service/LoginService.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:get/get.dart';

class CurrentPlaylistService extends GetxService{
  final Rx<CurrentPlaylistDto?> playlist = Rx(null);
  final RxList<MusicExtend> musics = RxList([]);
  late final LoginService loginService;

  @override void onInit() {
    loginService = Get.find<LoginService>();
    loginService.addOnLoginListener(fetchData);
    loginService.addOnLogoutListener(resetData);
    super.onInit();
  }

  Future<bool> fetchData() async {
    ApiResponse<CurrentPlaylistDto> response = await MusicService.getCurrentPlaylistByUserId();
    if(!response.isSuccess){
      StaticLogger.logger.e(response.exception);
    }
    else{
      musics.value = response.response!.playlist.map((e) => e.musicDto).toList();
    }
    StaticLogger.logger.i(response.response!);
    playlist.value = response.response!;

    return response.isSuccess;
  }

  void resetData(){
    playlist.value = null;
    musics.clear();
  }

  Future<void> addMusic(MusicExtend musicExtend)async{
    ApiResponse<dynamic> response = await MusicService.addMusicAtCurrentPlaylist(musicExtend.music.id);
    if(response.isSuccess){
      StaticLogger.logger.i("추가 성공 : ${response.response}");

      if(!await fetchData()){
        resetData();
        StaticLogger.logger.e("인터넷 연결 실패");
      }

      //playlist.refresh();
      //musics.refresh();
    }
    else{
      StaticLogger.logger.e(response.exception);
    }
  }

  Future<void> deleteMusic(int musicId) async {
    ApiResponse<dynamic> response = await MusicService.deleteMusicFromCurrentPlaylist(musicId);
    if (response.isSuccess) {
      StaticLogger.logger.i("삭제 성공");

      if(!await fetchData()){
        resetData();
        StaticLogger.logger.e("인터넷 연결 실패");
      }

      //playlist.refresh();
      //musics.refresh();

    } else {
      StaticLogger.logger.e(response.exception);
    }
  }
}