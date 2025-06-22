import 'package:flutter/material.dart';
import 'package:music_info/src/band_logos_list.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/features/pinkfloyd/pinkfloyd_band.dart';
import 'package:music_info/src/features/pinkfloyd/syd_barrett.dart';
import 'package:music_info/src/features/pinkfloyd/david_gilmour.dart';
import 'package:music_info/src/features/pinkfloyd/roger_waters.dart';
import 'package:music_info/src/features/pinkfloyd/nick_mason.dart';
import 'package:music_info/src/features/pinkfloyd/richard_wright.dart';
import 'package:music_info/src/common/info_text.dart';

class PinkFloydPage extends StatefulWidget {
  const PinkFloydPage({super.key});

  @override
  State<PinkFloydPage> createState() => _PinkFloydPageState();
}

class _PinkFloydPageState extends State<PinkFloydPage> {
  int? selectedPerson;

  void onPersonTapped(int index) {
    if (selectedPerson == index) {
      Widget nextPage;

      switch (index) {
        case 0:
          nextPage = const NickMasonPage();
          break;
        case 1:
          nextPage = const DavidGilmourPage();
          break;
        case 2:
          nextPage = const RogerWatersPage();
          break;
        case 3:
          nextPage = const SydBarrettPage();
          break;
        case 4:
          nextPage = const RichardWrightPage();
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
    final members = DatabaseRepository.pinkFloydMembers;

    final List<Map<String, double>> tapZones = [
      {'left': 20, 'top': size.height / 3.5 + 170, 'width': 120, 'height': 220},
      {'left': 90, 'top': size.height / 3.5 + 20, 'width': 110, 'height': 160},
      {'left': 160, 'top': size.height / 3.5 + 170, 'width': 70, 'height': 200},
      {'left': 230, 'top': size.height / 3.5 + 40, 'width': 80, 'height': 270},
      {'left': 310, 'top': size.height / 3.5 + 160, 'width': 85, 'height': 210},
    ];

    final Map<int, String> groupPhotos = {
      0: 'assets/fotos/nick_mason.jpg',
      1: 'assets/fotos/david_gilmour.jpg',
      2: 'assets/fotos/roger_waters.jpg',
      3: 'assets/fotos/syd_barrett.jpg',
      4: 'assets/fotos/richard_wright.jpg',
    };

    String currentBackground = selectedPerson != null
        ? groupPhotos[selectedPerson!]!
        : 'assets/fotos/pinkfloyd_band.jpg';

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
                  MaterialPageRoute(builder: (_) => const PinkFloydBandPage()),
                );
              },
              child: SizedBox(
                width: 240,
                child: Image.asset('assets/grafiken/PinkFloydsLogo-w.jpg'),
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
