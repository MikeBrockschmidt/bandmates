import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class TheSmithsBandPage extends StatelessWidget {
  const TheSmithsBandPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'The Smiths';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.theSmithsLogoPath,
      startImagePath: DatabaseRepository.theSmithsStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
