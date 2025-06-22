import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class BeatlesBandPage extends StatelessWidget {
  const BeatlesBandPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Beatles';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.beatlesLogoPath,
      startImagePath: DatabaseRepository.beatlesStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
