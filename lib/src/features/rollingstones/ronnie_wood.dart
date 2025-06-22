import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class RonnieWoodPage extends StatelessWidget {
  const RonnieWoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Ronnie Wood';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.rollingStonesLogoPath,
      startImagePath: DatabaseRepository.ronnieWoodStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
