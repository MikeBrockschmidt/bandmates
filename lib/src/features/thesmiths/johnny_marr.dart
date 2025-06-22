import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class JohnnyMarrPage extends StatelessWidget {
  const JohnnyMarrPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Johnny Marr';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.theSmithsLogoPath,
      startImagePath: DatabaseRepository.johnnyMarrStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
