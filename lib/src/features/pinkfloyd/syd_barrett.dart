import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class SydBarrettPage extends StatelessWidget {
  const SydBarrettPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Syd Barrett';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.pinkFloydLogoPath,
      startImagePath: DatabaseRepository.sydBarrettStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
