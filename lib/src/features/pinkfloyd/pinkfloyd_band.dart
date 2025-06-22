import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class PinkFloydBandPage extends StatelessWidget {
  const PinkFloydBandPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Pink Floyd';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.pinkFloydLogoPath,
      startImagePath: DatabaseRepository.pinkFloydStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
