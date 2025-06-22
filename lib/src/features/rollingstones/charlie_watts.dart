import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class CharlieWattsPage extends StatelessWidget {
  const CharlieWattsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Charlie Watts';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.rollingStonesLogoPath,
      startImagePath: DatabaseRepository.charlieWattsStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
