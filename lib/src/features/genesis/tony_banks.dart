import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class TonyBanksPage extends StatelessWidget {
  const TonyBanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Tony Banks';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.tonybanksStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
