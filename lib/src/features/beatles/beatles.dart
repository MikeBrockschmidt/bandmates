import 'package:flutter/material.dart';
import 'package:music_info/src/features/beatles/beatles_band.dart';
import 'package:music_info/src/theme/font_theme.dart';
import 'package:music_info/src/common/info_text.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';
import 'package:music_info/src/band_logos_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const BeatlesPage(),
    );
  }
}

class BeatlesPage extends StatefulWidget {
  const BeatlesPage({super.key});

  @override
  State<BeatlesPage> createState() => _BeatlesPageState();
}

class _BeatlesPageState extends State<BeatlesPage> {
  int? selectedPerson;

  void onPersonTapped(int index) {
    if (selectedPerson == index) {
      final member = DatabaseRepository.beatlesMembers[index];
      late Widget nextPage;

      switch (index) {
        case 0:
          nextPage = ArtistDetailPage(
            artistName: member.name,
            logoAssetPath: 'assets/grafiken/TheBeatlesLogo-kl.jpg',
            startImagePath: DatabaseRepository.georgeharrisonStartImagePath,
          );
          break;
        case 1:
          nextPage = ArtistDetailPage(
            artistName: member.name,
            logoAssetPath: 'assets/grafiken/TheBeatlesLogo-kl.jpg',
            startImagePath: DatabaseRepository.paulmccartneyStartImagePath,
          );
          break;
        case 2:
          nextPage = ArtistDetailPage(
            artistName: member.name,
            logoAssetPath: 'assets/grafiken/TheBeatlesLogo-kl.jpg',
            startImagePath: DatabaseRepository.johnlennonStartImagePath,
          );
          break;
        case 3:
          nextPage = ArtistDetailPage(
            artistName: member.name,
            logoAssetPath: 'assets/grafiken/TheBeatlesLogo-kl.jpg',
            startImagePath: DatabaseRepository.ringostarrStartImagePath,
          );
          break;
        default:
          return;
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
    final List<double> widths = [90, 110, 85, 83];
    final members = DatabaseRepository.beatlesMembers;

    String currentBackground = selectedPerson != null
        ? members[selectedPerson!].imagePath
        : 'assets/fotos/beatles.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 180,
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
            top: 40,
            left: (size.width - 240) / 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BeatlesBandPage()),
                );
              },
              child: SizedBox(
                width: 240,
                child: Image.asset('assets/grafiken/TheBeatlesLogo.jpg'),
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

          ...List.generate(4, (i) {
            double left = widths.sublist(0, i).fold(0, (a, b) => a + b);
            double width = widths[i];

            return Positioned(
              left: left,
              top: size.height / 3.5 + 40,
              width: width,
              height: 380,
              child: GestureDetector(
                onTap: () => onPersonTapped(i),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: selectedPerson == null || selectedPerson == i
                      ? 1
                      : 0.4,
                  child: Container(color: Colors.transparent),
                ),
              ),
            );
          }),
          if (selectedPerson != null)
            Positioned(
              left: 40,
              right: 40,
              bottom: 20,
              child: SizedBox(
                height: 180,
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
