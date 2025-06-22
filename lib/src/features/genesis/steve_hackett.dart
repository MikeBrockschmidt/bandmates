import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class SteveHackettPage extends StatelessWidget {
  const SteveHackettPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Steve Hackett';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.stevehacketStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
