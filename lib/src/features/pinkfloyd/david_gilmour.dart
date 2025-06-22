import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class DavidGilmourPage extends StatelessWidget {
  const DavidGilmourPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'David Gilmour';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.pinkFloydLogoPath,
      startImagePath: DatabaseRepository.davidGilmourStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
