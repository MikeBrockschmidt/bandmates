import 'package:flutter/material.dart';
import 'package:music_info/src/band_logos_list.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/features/rollingstones/bill_wyman.dart';
import 'package:music_info/src/features/rollingstones/charlie_watts.dart';
import 'package:music_info/src/features/rollingstones/keith_richards.dart';
import 'package:music_info/src/features/rollingstones/mick_jagger.dart';
import 'package:music_info/src/features/rollingstones/rollingstones_band.dart';
import 'package:music_info/src/features/rollingstones/ronnie_wood.dart';
import 'package:music_info/src/common/info_text.dart';

class RollingStonesPage extends StatefulWidget {
  const RollingStonesPage({super.key});

  @override
  State<RollingStonesPage> createState() => _RollingStonesPageState();
}

class _RollingStonesPageState extends State<RollingStonesPage> {
  int? selectedPerson;

  void onPersonTapped(int index) {
    if (selectedPerson == index) {
      Widget nextPage;

      switch (index) {
        case 0:
          nextPage = const RonnieWoodPage();
          break;
        case 1:
          nextPage = const MickJaggerPage();
          break;
        case 2:
          nextPage = const CharlieWattsPage();
          break;
        case 3:
          nextPage = const KeithRichardsPage();
          break;
        case 4:
          nextPage = const BillWymanPage();
          break;
        default:
          nextPage = const Scaffold(
            body: Center(child: Text('Detailseite folgt...')),
          );
      }

      Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));
    } else {
      setState(() {
        selectedPerson = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final members = DatabaseRepository.rollingStonesMembers;

    final List<Map<String, double>> tapZones = [
      {'left': 20, 'top': size.height / 3.5 + 30, 'width': 90, 'height': 230},
      {'left': 110, 'top': size.height / 3.5 + 20, 'width': 70, 'height': 240},
      {'left': 180, 'top': size.height / 3.5 + 50, 'width': 80, 'height': 170},
      {'left': 260, 'top': size.height / 3.5 + 30, 'width': 70, 'height': 210},
      {'left': 330, 'top': size.height / 3.5 + 30, 'width': 85, 'height': 210},
    ];

    final Map<int, String> groupPhotos = {
      0: 'assets/fotos/ron_wood.jpg',
      1: 'assets/fotos/mick_jagger.jpg',
      2: 'assets/fotos/charlie_watts.jpg',
      3: 'assets/fotos/keith_richards.jpg',
      4: 'assets/fotos/bill_wyman.jpg',
    };

    String currentBackground = selectedPerson != null
        ? groupPhotos[selectedPerson!]!
        : 'assets/fotos/rollingstones_band.jpg';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: Image.asset(
                currentBackground,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            top: 90,
            left: (size.width - 240) / 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RollingStonesBandPage(),
                  ),
                );
              },
              child: SizedBox(
                width: 240,
                child: Image.asset('assets/grafiken/RollingStonesLogo-w.png'),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BandLogosList()),
                );
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/icons/vinyl.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          ),
          ...List.generate(tapZones.length, (i) {
            final zone = tapZones[i];
            final List<Color> tapColors = [
              Colors.purple.withValues(alpha: 0.0),
              Colors.red.withValues(alpha: 0.0),
              Colors.green.withValues(alpha: 0.0),
              Colors.blue.withValues(alpha: 0.0),
              Colors.yellow.withValues(alpha: 0.0),
            ];

            return Positioned(
              left: zone['left']!,
              top: zone['top']!,
              width: zone['width']!,
              height: zone['height']!,
              child: GestureDetector(
                onTap: () => onPersonTapped(i),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: selectedPerson == null || selectedPerson == i
                      ? 1
                      : 0.4,
                  child: Container(color: tapColors[i]),
                ),
              ),
            );
          }),
          if (selectedPerson != null)
            Positioned(
              left: 30,
              right: 30,
              bottom: 100,
              child: SizedBox(
                height: 140,
                child: InfoText(
                  name: members[selectedPerson!].name,
                  birthday: members[selectedPerson!].birthday,
                  info: members[selectedPerson!].info,
                  musicGroups: members[selectedPerson!].musicGroups,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
