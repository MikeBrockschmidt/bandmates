import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class RichardWrightPage extends StatelessWidget {
  const RichardWrightPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Richard Wright';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.pinkFloydLogoPath,
      startImagePath: DatabaseRepository.richardWrightStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
