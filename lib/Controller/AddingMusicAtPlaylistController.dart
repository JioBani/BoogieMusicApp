import 'package:database_project/Common/MusicApiResponse.dart';
import 'package:database_project/Model/Playlist/Playlist.dart';
import 'package:database_project/Model/Playlist/PlaylistExtend.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:get/get.dart';


class AddingMusicAtPlaylistController extends GetxController {

  final RxList<PlaylistExtend> playlistList = RxList();


  @override void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    // MusicApiResponse<List<Playlist>> response =  await MusicService.getPlaylistsByUserId("user01");
    // if(response.isSuccess){
    //   playlistList.value = response.response!;
    // }
    // else{
    //
    // }
  }
}