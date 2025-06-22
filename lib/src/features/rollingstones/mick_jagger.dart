import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class MickJaggerPage extends StatelessWidget {
  const MickJaggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Mick Jagger';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.rollingStonesLogoPath,
      startImagePath: DatabaseRepository.mickJaggerStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
