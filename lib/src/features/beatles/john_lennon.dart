import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class JohnLennonPage extends StatelessWidget {
  const JohnLennonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'John Lennon';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.beatlesLogoPath,
      startImagePath: DatabaseRepository.johnlennonStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
