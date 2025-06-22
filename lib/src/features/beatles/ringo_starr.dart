import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class RingoStarrPage extends StatelessWidget {
  const RingoStarrPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Ringo Starr';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.beatlesLogoPath,
      startImagePath: DatabaseRepository.ringostarrStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
