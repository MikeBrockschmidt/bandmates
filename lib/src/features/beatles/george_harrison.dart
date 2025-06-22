import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class GeorgeHarrisonPage extends StatelessWidget {
  const GeorgeHarrisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'George Harrison';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.beatlesLogoPath,
      startImagePath: DatabaseRepository.georgeharrisonStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
