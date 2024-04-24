import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/TopChart/TopChart.dart';

class TopChartElementDto{
  TopChart info;
  MusicExtend musicDto;

  TopChartElementDto({required this.info , required this.musicDto});

  factory TopChartElementDto.fromMap(Map<String,dynamic> map){
    return TopChartElementDto(
        info: TopChart.fromMap(map['info']),
        musicDto: MusicExtend.fromMap(map['musicDto'])
    );
  }
}