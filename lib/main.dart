import 'package:database_project/Controller/PlayerController.dart';
import 'package:database_project/Service/CurrentPlaylistService.dart';
import 'package:database_project/Service/PlayerService.dart';
import 'package:database_project/Service/PlaylistService.dart';
import 'package:database_project/View/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());

  Get.put(PlayerService() , permanent: true);
  Get.put(CurrentPlaylistService() , permanent: true);
  Get.put(PlaylistService() , permanent: true);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}