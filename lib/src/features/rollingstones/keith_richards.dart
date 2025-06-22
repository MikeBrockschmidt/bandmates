import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class KeithRichardsPage extends StatelessWidget {
  const KeithRichardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Keith Richards';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.rollingStonesLogoPath,
      startImagePath: DatabaseRepository.keithRichardsStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
