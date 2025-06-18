import 'package:flutter/material.dart';
import 'package:music_info/src/features/beatles.dart';

class BandLogosList extends StatelessWidget {
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

        return InkWell(
          onTap: () {
            if (logo == 'assets/grafiken/TheBeatlesLogoW-kl.jpg') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BeatlesPage()),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(logo, height: 140, fit: BoxFit.contain),
          ),
        );
      },
    );
  }
}
