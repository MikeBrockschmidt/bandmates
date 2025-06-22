import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class MorrisseyPage extends StatelessWidget {
  const MorrisseyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Morrissey';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.theSmithsLogoPath,
      startImagePath: DatabaseRepository.morrisseyStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
