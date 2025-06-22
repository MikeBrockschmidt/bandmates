import 'package:flutter/material.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:music_info/src/common/artist_screen.dart';

class BillWymanPage extends StatelessWidget {
  const BillWymanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const artistName = 'Bill Wyman';

    return ArtistDetailPage(
      artistName: artistName,
      logoAssetPath: DatabaseRepository.rollingStonesLogoPath,
      startImagePath: DatabaseRepository.billWymanStartImagePath,
      additionalArtists: DatabaseRepository.getAdditionalArtistsFor(artistName),
    );
  }
}
