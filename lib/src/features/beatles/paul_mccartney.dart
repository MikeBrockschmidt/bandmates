import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class PaulMcCartneyPage extends StatelessWidget {
  const PaulMcCartneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Paul McCartney';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.beatlesLogoPath,
      startImagePath: DatabaseRepository.paulmccartneyStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
