// import 'package:database_project/Common/ApiResponse.dart';
// import 'package:database_project/Common/StaticLogger.dart';
// import 'package:database_project/Model/CurrentPlaylist/CurrentPlaylist.dart';
// import 'package:database_project/Model/Music.dart';
// import 'package:database_project/Service/MusicService.dart';
// import 'package:get/get.dart';
//
// class CurrentPlaylistPageController extends GetxController{
//   final Rx<CurrentPlaylist?> playlist = Rx(null);
//   final RxList<Music> musics = RxList([]);
//
//   @override void onInit() {
//     super.onInit();
//     fetchData();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   Future<void> fetchData() async {
//     MusicApiResponse<CurrentPlaylist> response = await MusicService.getCurrentPlaylistByUserId("user01");
//     if(!response.isSuccess){
//       StaticLogger.logger.e(response.exception);
//     }
//     else{
//       musics.value = response.response!.musics;
//     }
//     playlist.value = response.response!;
//   }
//
//   Future<void> deleteMusic(int musicId) async {
//     MusicApiResponse<dynamic> response = await MusicService.deleteMusicFromCurrentPlaylist("user01" , musicId);
//     if(response.isSuccess){
//       playlist.value?.musics.removeWhere((music) => music.id == musicId);
//       musics.removeWhere((music) => music.id == musicId);
//       StaticLogger.logger.i("삭제 성공");
//     }
//     else{
//       StaticLogger.logger.e(response.exception);
//     }
//   }
// }