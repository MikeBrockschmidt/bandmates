import 'package:flutter/material.dart';
import 'package:music_info/src/features/beatles/beatles.dart';
import 'package:music_info/src/features/genesis/genesis.dart';
import 'package:music_info/src/features/pinkfloyd/pink_floyd.dart';
import 'package:music_info/src/features/rollingstones/rolling_stones.dart';
import 'package:music_info/src/features/thesmiths/the_smiths.dart';

class BandLogosList extends StatelessWidget {
  BandLogosList({super.key});

  final List<String> bandLogos = [
    'assets/grafiken/TheBeatlesLogoW-kl.jpg',
    'assets/grafiken/The_Rolling_Stones.png',
    'assets/grafiken/Pink_Floyd.jpg',
    'assets/grafiken/Genesis.jpg',
    'assets/grafiken/TheSmiths.jpg',
    'assets/grafiken/marillion.jpg',
    'assets/grafiken/nirvana.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bandLogos.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
      itemBuilder: (context, index) {
        final logo = bandLogos[index];

        return Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              if (logo == 'assets/grafiken/Genesis.jpg') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GenesisPage()),
                );
              }
              if (logo == 'assets/grafiken/The_Rolling_Stones.png') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RollingStonesPage(),
                  ),
                );
              }
              if (logo == 'assets/grafiken/Pink_Floyd.jpg') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PinkFloydPage(),
                  ),
                );
              }
              if (logo == 'assets/grafiken/TheSmiths.jpg') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TheSmithsPage(),
                  ),
                );
              }
              if (logo == 'assets/grafiken/TheBeatlesLogoW-kl.jpg') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BeatlesPage()),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(logo, height: 140, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }
}
