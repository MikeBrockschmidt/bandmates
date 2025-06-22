import 'package:flutter/material.dart';
import 'package:music_info/src/band_logos_list.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/features/genesis/genesis_band.dart';
import 'package:music_info/src/features/genesis/tony_banks.dart';
import 'package:music_info/src/features/genesis/phil_collins.dart';
import 'package:music_info/src/features/genesis/mike_rutherford.dart';
import 'package:music_info/src/features/genesis/steve_hackett.dart';
import 'package:music_info/src/features/genesis/peter_gabriel.dart';
import 'package:music_info/src/theme/font_theme.dart';
import 'package:music_info/src/common/info_text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const GenesisPage(),
    );
  }
}

class GenesisPage extends StatefulWidget {
  const GenesisPage({super.key});

  @override
  State<GenesisPage> createState() => _GenesisPageState();
}

class _GenesisPageState extends State<GenesisPage> {
  int? selectedPerson;

  void onPersonTapped(int index) {
    if (selectedPerson == index) {
      Widget nextPage;

      switch (index) {
        case 0:
          nextPage = const TonyBanksPage();
          break;
        case 1:
          nextPage = const PhilCollinsPage();
          break;
        case 2:
          nextPage = const MikeRutherfordPage();
          break;
        case 3:
          nextPage = const SteveHackettPage();
          break;
        case 4:
          nextPage = const PeterGabrielPage();
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
    final members = DatabaseRepository.genesisMembers;

    final List<Map<String, double>> tapZones = [
      {'left': 20, 'top': size.height / 3.5 + 40, 'width': 70, 'height': 260},
      {'left': 100, 'top': size.height / 3.5 + 50, 'width': 60, 'height': 260},
      {'left': 160, 'top': size.height / 3.5 + 30, 'width': 70, 'height': 280},
      {'left': 230, 'top': size.height / 3.5 + 40, 'width': 80, 'height': 270},
      {'left': 310, 'top': size.height / 3.5 + 46, 'width': 65, 'height': 270},
    ];

    final Map<int, String> groupPhotos = {
      0: 'assets/fotos/tony_banks.jpg',
      1: 'assets/fotos/phil_collins.jpg',
      2: 'assets/fotos/mike_rutherford.jpg',
      3: 'assets/fotos/steve_hackett.jpg',
      4: 'assets/fotos/peter_gabriel.jpg',
    };

    String currentBackground = selectedPerson != null
        ? groupPhotos[selectedPerson!]!
        : 'assets/fotos/genesis_band.jpg';

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
                  MaterialPageRoute(builder: (_) => const GenesisBandPage()),
                );
              },
              child: SizedBox(
                width: 240,
                child: Image.asset('assets/grafiken/Genesis.jpg'),
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
              bottom: 130,
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
