import 'package:flutter/material.dart';
import 'package:music_info/src/band_logos_list.dart';
import 'package:music_info/src/theme/font_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black),
        body: BandLogosList(),
      ),
    );
  }
}
