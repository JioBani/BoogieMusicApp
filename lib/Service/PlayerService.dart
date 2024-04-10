import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Service/CurrentPlaylistService.dart';
import 'package:get/get.dart';


class PlayerService extends GetxService{
  final Rx<MusicExtend?> nowPlay = Rx(null);

  void setPlay(MusicExtend music){
    nowPlay.value = music;
    Get.find<CurrentPlaylistService>().addMusic(music);
  }

  void stop(){
    nowPlay.value = null;
  }
}