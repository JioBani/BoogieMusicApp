import 'package:database_project/Common/StaticLogger.dart';
import 'package:database_project/Model/MusicExtend.dart';

import 'TopChartElementDto.dart';

class TopChartDto{
  List<TopChartElementDto> topChart;

  TopChartDto({required this.topChart});

  factory TopChartDto.fromMap(Map<String, dynamic> map){
    return TopChartDto(
        topChart: (map['topChart'] as List<dynamic>).map((e) => TopChartElementDto.fromMap(e)).toList()
    );
  }

  List<MusicExtend> getMusicList(){
    return topChart.map((e) => e.musicDto).toList();
  }
}