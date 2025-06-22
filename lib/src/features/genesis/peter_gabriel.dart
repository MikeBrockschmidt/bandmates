import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class PeterGabrielPage extends StatelessWidget {
  const PeterGabrielPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Peter Gabriel';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.petergabrielStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
