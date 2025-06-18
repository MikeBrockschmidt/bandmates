import 'package:flutter/material.dart';
import 'package:music_info/src/theme/font_theme.dart';
import 'package:music_info/src/common/info_text.dart';
import 'package:music_info/src/features/beatles/george.dart';
import 'package:music_info/src/features/beatles/paul.dart';
import 'package:music_info/src/features/beatles/john.dart';
import 'package:music_info/src/features/beatles/ringo.dart';
import 'package:music_info/src/data/database_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: const BeatlesPage());
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
      Widget nextPage;
      switch (index) {
        case 0:
          nextPage = const GeorgeDetailPage();
          break;
        case 1:
          nextPage = const PaulDetailPage();
          break;
        case 2:
          nextPage = const JohnDetailPage();
          break;
        case 3:
          nextPage = const RingoDetailPage();
          break;
        default:
          nextPage = const Text('Unbekannte Person');
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

    String currentBackground = selectedPerson != null
        ? DatabaseRepository.beatlesMembers[selectedPerson!].imagePath
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
                setState(() {
                  selectedPerson = null;
                });
              },
              child: SizedBox(
                width: 240,
                child: Image.asset('assets/grafiken/TheBeatlesLogo.jpg'),
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
              bottom: 90,
              child: SizedBox(
                height: 110,
                child: InfoText(
                  name: DatabaseRepository.beatlesMembers[selectedPerson!].name,
                  birthday: DatabaseRepository
                      .beatlesMembers[selectedPerson!]
                      .birthday,
                  info: DatabaseRepository.beatlesMembers[selectedPerson!].info,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
