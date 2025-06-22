import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class GenesisBandPage extends StatelessWidget {
  const GenesisBandPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Genesis';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.genesisStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
