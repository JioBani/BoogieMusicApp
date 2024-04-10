import 'package:database_project/Common/ImageUrls.dart';
import 'package:logger/logger.dart';
import 'Music.dart';

class PlaylistLibraryItemData{
   String name;
   String imageUrl;
   List<Music> musicList;

   PlaylistLibraryItemData({required this.name , required this.imageUrl , required this.musicList});

     factory PlaylistLibraryItemData.fromJson(Map<String, dynamic> json){
     Logger().i(json);
     List<dynamic> musicList = json['musicList'];



     return PlaylistLibraryItemData(
        name: json['name'],
        imageUrl: json['imageUrl'],
        musicList: musicList.map((e) => Music.fromMap(e)).toList()
     );
   }
}