import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class MikeJoycePage extends StatelessWidget {
  const MikeJoycePage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Mike Joyce';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.theSmithsLogoPath,
      startImagePath: DatabaseRepository.mikeJoyceStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
