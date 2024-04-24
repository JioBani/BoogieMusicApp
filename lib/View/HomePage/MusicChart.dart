import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Model/TopChart/TopChart.dart';
import 'package:database_project/Service/MusicService.dart';
import 'package:database_project/View/RankingElementWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class MusicChart extends StatelessWidget {
  const MusicChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      child: Column(
        children: [
          Text(
            "인기차트",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 20.h,),
          FutureBuilder(
            future: MusicService.getTopChart(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('오류: ${snapshot.error}'));
              } else {
                if(!snapshot.data!.isSuccess){
                  return Center(
                    child: Text("데이터를 불러 올 수 없습니다."),
                  );
                }
                else{
                  List<MusicExtend> musics = snapshot.data!.response!.getMusicList();
                  return Builder(
                      builder: (context) {
                        List<Widget> musicList = [];

                        for (int i = 0; i < musics.length; i++) {
                          musicList.add(
                              RankingElementWidget(music: musics[i] , ranking: i + 1)
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(left: 10.w , right: 10.w),
                          child: Column(
                            children: musicList,
                          ),
                        );
                      }
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
