import 'package:database_project/Model/PlaylistLibraryItemData.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetxControllerTest extends GetxController{

  RxInt textValue = 0.obs;
  final Rx<PlaylistLibraryItemData?> playlistLibraryItemData = Rx<PlaylistLibraryItemData?>(null);

  Future<void> valueUp()async {
    await Future.delayed(Duration(seconds: 1));
    textValue.value++;
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:80/playlist.json'));

    if (response.statusCode == 200) {
      // JSON 데이터 파싱하여 Music 객체 리스트로 변환
      final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      playlistLibraryItemData.value = PlaylistLibraryItemData.fromJson(jsonData);
      update();
    } else {
      throw Exception('데이터 가져오기 실패');
    }
  }
}