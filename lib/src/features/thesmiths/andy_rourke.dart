import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class AndyRourkePage extends StatelessWidget {
  const AndyRourkePage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Andy Rourke';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.theSmithsLogoPath,
      startImagePath: DatabaseRepository.andyRourkeStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
