import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class NickMasonPage extends StatelessWidget {
  const NickMasonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Nick Mason';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.pinkFloydLogoPath,
      startImagePath: DatabaseRepository.nickMasonStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
