import 'dart:math';
import 'dart:ui';

import 'package:database_project/Controller/PlayerController.dart';
import 'package:database_project/Model/Music.dart';
import 'package:database_project/Model/MusicExtend.dart';
import 'package:database_project/Service/PlayerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:widget_mask/widget_mask.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:palette_generator/palette_generator.dart';

//const String tempImage = "https://ibighit.com/bts/images/bts/discography/butter/butter-cover.jpg";
//const String orangeImage = "https://ibighit.com/bts/images/bts/discography/butter-2/butter-2-cover.jpg";


class MusicPlayPage extends StatelessWidget {
  const MusicPlayPage({super.key, required this.music});

  final MusicExtend music;

  Future<PaletteGenerator> getImagePalette () async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        Image.network(
          music.music.imageUrl,
        ).image
    );

    return paletteGenerator;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getImagePalette(),
          builder: (context , snapshot) {
            PaletteGenerator? paletteGenerator;
            LinearGradient? gradient;

            if(snapshot.hasData){
              paletteGenerator = snapshot.data!;
              gradient = LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  0.5,
                ],
                colors: [
                  paletteGenerator.dominantColor!.color.withOpacity(0.5),
                  paletteGenerator.lightVibrantColor!.color.withOpacity(0.3)
                ],
              );
            }

            return Container(
              decoration: BoxDecoration(
                gradient: gradient,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  DiscographyWidget(imageUrl: music.music.imageUrl,),
                  SizedBox(height: 20.h,),
                  Text(
                    music.music.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    "TODO / TODO",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.w,0,30.w,0),
                    child: ProgressBar(
                      progress: Duration(seconds: 62),
                      buffered: Duration(seconds: 140),
                      total: Duration(seconds: 227),
                      onSeek: (duration) {
                        print('User selected a new time: $duration');
                      },
                      progressBarColor: paletteGenerator != null ? paletteGenerator.dominantColor!.color : Colors.black,
                      baseBarColor: Colors.black.withOpacity(0.24),
                      bufferedBarColor: Colors.black.withOpacity(0.24),
                      thumbColor: Colors.black,
                      barHeight: 5.0,
                      thumbRadius: 5.0,
                    ),
                  ),
                  Expanded(child: SizedBox()),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){

                        },
                        icon: Center(
                          child: Icon(
                            Icons.skip_previous_rounded,
                            size: 45.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      GetX<PlayerService>(
                        builder: (service) {
                          if(service.nowPlay.value == null){
                            return IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                service.setPlay(music);
                              },
                              icon: Icon(
                                Icons.play_arrow,
                                size: 45.sp,
                              ),
                            );
                          }
                          else if(service.nowPlay.value!.music.id != music.music.id){
                            return IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                service.setPlay(music);
                              },
                              icon: Icon(
                                Icons.play_arrow,
                                size: 45.sp,
                              ),
                            );
                          }
                          else{
                            return IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                service.stop();
                              },
                              icon: Icon(
                                Icons.pause,
                                size: 45.sp,
                              ),
                            );
                          }
                        }
                      ),
                      SizedBox(width: 20.w,),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){

                        },
                        icon: Center(
                          child: Icon(
                            Icons.skip_next_rounded,
                            size: 45.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h,)
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

class DiscographyWidget extends StatefulWidget {
  const DiscographyWidget({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<DiscographyWidget> createState() => _DiscographyWidgetState();
}

class _DiscographyWidgetState extends State<DiscographyWidget> with SingleTickerProviderStateMixin {

  double degree = 0;
  double radian = 0;

  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(seconds: 10))..repeat();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //rotate();
    return Padding(
      padding: EdgeInsets.fromLTRB(40.w, 0, 40.w, 0),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: SimpleShadow(
                opacity: 0.2,
                sigma: 7,
                offset: Offset(0,2),
                child: WidgetMask(
                  mask: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.fill,
                  ),
                  child: Image.asset("assets/images/disk.png"),
                  blendMode: BlendMode.srcATop,
                  childSaveLayer: true,
                ),
              ),
            );
          },
          child: FlutterLogo(size: 200),
        ),
      /*child: Transform.rotate(
        angle: radian,
        child: WidgetMask(
          mask: Image.network(
            tempImage,
          ),
          child: Image.asset("assets/images/disk.png"),
          blendMode: BlendMode.srcATop,
          childSaveLayer: true,
        ),
      ),*/
    );
  }
}
