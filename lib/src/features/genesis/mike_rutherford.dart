import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class MikeRutherfordPage extends StatelessWidget {
  const MikeRutherfordPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Mike Rutherford';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.genesisLogoPath,
      startImagePath: DatabaseRepository.mikerutherfordstartStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
