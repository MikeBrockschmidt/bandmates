import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class PhilCollinsPage extends StatelessWidget {
  const PhilCollinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Phil Collins';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.philcollinsStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
