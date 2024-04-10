// import 'package:database_project/Model/Music.dart';
// import 'package:database_project/Service/CurrentPlaylistService.dart';
// import 'package:database_project/Service/MusicService.dart';
// import 'package:get/get.dart';
//
// class PlayerController extends GetxController{
//   final Rx<Music?> nowPlay = Rx(null);
//
//   void setPlay(Music music){
//     nowPlay.value = music;
//     Get.find<CurrentPlaylistService>().addMusic(music);
//     //MusicService.addMusicAtCurrentPlaylist("user01", music.id).then((value) => print('음악추가됨'));
//   }
//
//   void stop(){
//     nowPlay.value = null;
//   }
// }