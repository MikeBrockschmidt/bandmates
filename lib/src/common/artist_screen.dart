import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:music_info/src/data/spotify_api_service.dart';

class ArtistDetailPage extends StatelessWidget {
  final String artistName;
  final String logoAssetPath;
  final String startImagePath;
  final List<String> additionalArtists;

  const ArtistDetailPage({
    super.key,
    required this.artistName,
    required this.logoAssetPath,
    required this.startImagePath,
    this.additionalArtists = const [],
  });

  @override
  Widget build(BuildContext context) {
    return ArtistAlbumScreen(
      artistName: artistName,
      logoAssetPath: logoAssetPath,
      startImagePath: startImagePath,
      additionalArtists: additionalArtists,
    );
  }
}

class ArtistAlbumScreen extends StatefulWidget {
  final String artistName;
  final String logoAssetPath;
  final String startImagePath;
  final List<String> additionalArtists;

  const ArtistAlbumScreen({
    super.key,
    required this.artistName,
    required this.logoAssetPath,
    required this.startImagePath,
    this.additionalArtists = const [],
  });

  @override
  State<ArtistAlbumScreen> createState() => _ArtistAlbumScreenState();
}

class _ArtistAlbumScreenState extends State<ArtistAlbumScreen> {
  late final SpotifyApiService _spotifyApiService;

  String _albumName = '';
  String _releaseDate = '';
  String _coverArtUrl = '';
  String _albumArtistName = '';
  String _errorMessage = '';
  String? _albumSpotifyUrl;
  bool _isLoading = false;
  Timer? _albumChangeTimer;

  final Random _random = Random();
  final List<String> _combinedArtistList = [];

  @override
  void initState() {
    super.initState();
    _spotifyApiService = SpotifyApiService(
      clientId: '84c01916df48423d97dd830aa03de7ae',
      clientSecret: '1300b351696d4a4e88251e447d102196',
    );

    _combinedArtistList
      ..add(widget.artistName)
      ..addAll(widget.additionalArtists);

    _initializeSpotifyData();
  }

  @override
  void dispose() {
    _cancelAlbumRefreshTimer();
    super.dispose();
  }

  Future<void> _initializeSpotifyData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _coverArtUrl = '';
    });

    try {
      await _spotifyApiService.getAccessToken();

      final selectedArtist =
          _combinedArtistList[_random.nextInt(_combinedArtistList.length)];

      final artistId = await _spotifyApiService.searchArtistId(selectedArtist);

      if (artistId != null && artistId.isNotEmpty) {
        await _displayRandomAlbumFromArtist(artistId, selectedArtist);
        _startAlbumRefreshTimer();
      } else {
        setState(() {
          _errorMessage = 'Künstler nicht gefunden: $selectedArtist';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Fehler: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _displayRandomAlbumFromArtist(
    String artistId,
    String artistName,
  ) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _coverArtUrl = '';
      _errorMessage = '';
    });

    try {
      final album = await _spotifyApiService.fetchRandomAlbumForArtistId(
        artistId,
      );

      if (album != null) {
        setState(() {
          _albumName = album['name'] ?? 'Unbekanntes Album';
          _releaseDate = album['release_date'] ?? 'Unbekanntes Datum';
          _coverArtUrl = album['cover_art_url'] ?? '';
          _albumSpotifyUrl = album['spotify_url'];
          _albumArtistName = artistName;
        });
      } else {
        setState(() {
          _errorMessage = 'Keine Alben gefunden.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Fehler beim Laden des Albums: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startAlbumRefreshTimer() {
    _albumChangeTimer?.cancel();
    _albumChangeTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final selectedArtist =
          _combinedArtistList[_random.nextInt(_combinedArtistList.length)];
      final artistId = await _spotifyApiService.searchArtistId(selectedArtist);

      if (!mounted) return;
      if (artistId != null) {
        await _displayRandomAlbumFromArtist(artistId, selectedArtist);
      }
    });
  }

  void _cancelAlbumRefreshTimer() {
    _albumChangeTimer?.cancel();
  }

  Future<void> _launchSpotifyAlbumUrl() async {
    if (_albumSpotifyUrl != null && _albumSpotifyUrl!.isNotEmpty) {
      final Uri url = Uri.parse(_albumSpotifyUrl!);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        setState(() {
          _errorMessage = 'Konnte URL nicht öffnen: $_albumSpotifyUrl';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDisplayArtist = _albumArtistName.isNotEmpty
        ? _albumArtistName
        : widget.artistName;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  widget.logoAssetPath,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${widget.artistName} Discography',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              _buildErrorWidget()
            else if (_isLoading)
              _buildLoadingWidget()
            else if (_coverArtUrl.isEmpty && _albumName.isEmpty)
              _buildInitialWidget()
            else
              _buildAlbumCard(currentDisplayArtist),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() => Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.red[50],
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Text(
      _errorMessage,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red[700], fontSize: 16),
    ),
  );

  Widget _buildLoadingWidget() => Center(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircularProgressIndicator(color: Colors.green),
          const SizedBox(height: 10),
          Text(
            'Lade Daten...',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );

  Widget _buildInitialWidget() => Column(
    children: [
      Image.asset(widget.startImagePath, height: 400),
      const SizedBox(height: 20),
      const Text(
        'Lade Albumdaten. Bitte warten...',
        style: TextStyle(fontSize: 16, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    ],
  );

  Widget _buildAlbumCard(String artistNameToDisplay) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.1),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: _coverArtUrl.isEmpty
              ? Image.asset(
                  widget.startImagePath,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  _coverArtUrl,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  artistNameToDisplay,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.open_in_new,
                  color: Colors.green,
                  size: 24,
                ),
                onPressed:
                    (_albumSpotifyUrl == null ||
                        _albumSpotifyUrl!.isEmpty ||
                        _isLoading)
                    ? null
                    : _launchSpotifyAlbumUrl,
                tooltip: 'Album auf Spotify öffnen',
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              _albumName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'VÖ: $_releaseDate',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    ),
  );
}
