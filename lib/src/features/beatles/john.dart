import 'dart:math';
import 'package:music_info/src/data/spotify_api_service.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:music_info/src/theme/font_theme.dart';
import 'package:music_info/src/features/beatles.dart';
import 'package:music_info/src/data/database_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const JohnDetailPage());
}

class JohnDetailPage extends StatelessWidget {
  const JohnDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const JohnLennonAlbumScreen(),
    );
  }
}

class JohnLennonAlbumScreen extends StatefulWidget {
  const JohnLennonAlbumScreen({super.key});

  @override
  State<JohnLennonAlbumScreen> createState() => _JohnLennonAlbumScreenState();
}

class _JohnLennonAlbumScreenState extends State<JohnLennonAlbumScreen> {
  late final SpotifyApiService _spotifyApiService;

  static const List<String> _fixedArtistNames = [
    "John Lennon",
    "Plastic Ono Band",
    "The Quarrymen",
  ];

  final Map<String, String> _foundArtistIds = {};

  String _currentArtistName = '';
  String _albumName = '';
  String _releaseDate = '';
  String _coverArtUrl = '';
  String _errorMessage = '';
  String? _albumSpotifyUrl;
  bool _isLoading = false;
  Timer? _albumChangeTimer;

  @override
  void initState() {
    super.initState();
    _spotifyApiService = SpotifyApiService(
      clientId: '84c01916df48423d97dd830aa03de7ae',
      clientSecret: '1300b351696d4a4e88251e447d102196',
    );
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
      await _findAndStoreAllFixedArtistIds();

      if (_foundArtistIds.isNotEmpty) {
        await _displayRandomAlbumFromFixedArtists();
        _startAlbumRefreshTimer();
      } else {
        setState(() {
          _errorMessage = 'Keine Künstlernamen gefunden oder fehlerhaft.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Initialisierungsfehler: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _findAndStoreAllFixedArtistIds() async {
    _foundArtistIds.clear();
    setState(() {
      _coverArtUrl = '';
    });

    try {
      for (String artistName in _fixedArtistNames) {
        final artistId = await _spotifyApiService.searchArtistId(artistName);
        if (artistId != null && artistId.isNotEmpty) {
          _foundArtistIds[artistName] = artistId;
        }
      }

      if (_foundArtistIds.isEmpty) {
        setState(() {
          _errorMessage =
              'Keiner der festgelegten Interpreten auf Spotify gefunden.';
          _coverArtUrl = '';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Fehler beim Finden der Künstler-IDs: ${e.toString()}';
      });
    }
  }

  Future<void> _displayRandomAlbumFromFixedArtists() async {
    if (_isLoading || _foundArtistIds.isEmpty) return;

    setState(() {
      _isLoading = true;
      _coverArtUrl = '';
      _errorMessage = '';
    });

    try {
      final random = Random();
      final List<String> availableArtistNames = _foundArtistIds.keys.toList();

      if (availableArtistNames.isEmpty) {
        setState(() {
          _errorMessage = 'Keine Künstler-IDs verfügbar, um Alben zu laden.';
        });
        return;
      }

      final String selectedArtistName =
          availableArtistNames[random.nextInt(availableArtistNames.length)];
      final String selectedArtistId = _foundArtistIds[selectedArtistName]!;

      final album = await _spotifyApiService.fetchRandomAlbumForArtistId(
        selectedArtistId,
      );

      if (album != null) {
        setState(() {
          _currentArtistName = selectedArtistName;
          _albumName = album['name'] ?? 'Unbekanntes Album';
          _releaseDate = album['release_date'] ?? 'Unbekanntes Datum';
          _coverArtUrl = album['cover_art_url'] ?? '';
          _albumSpotifyUrl = album['spotify_url'];
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage =
              'Keine Alben für $selectedArtistName gefunden oder Fehler beim Abruf.';
          _coverArtUrl = '';
          _albumName = '';
          _releaseDate = '';
          _albumSpotifyUrl = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Fehler beim Abrufen des nächsten Albums: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startAlbumRefreshTimer() {
    _albumChangeTimer?.cancel();
    _albumChangeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _displayRandomAlbumFromFixedArtists();
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
    } else {
      setState(() {
        _errorMessage = 'Keine Spotify Album URL verfügbar.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BeatlesPage()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/grafiken/TheBeatlesLogo-kl.jpg',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Text(
                  'John Lennon Discography',
                  style: TextStyle(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage.isNotEmpty)
              Container(
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
              )
            else if (_isLoading)
              Center(
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
              )
            else if (_coverArtUrl.isEmpty &&
                _albumName.isEmpty &&
                _currentArtistName.isEmpty)
              Column(
                children: [
                  Image.asset(
                    DatabaseRepository.johnStartImagePath,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Lade Albumdaten. Bitte warten...',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            else
              Container(
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
                              DatabaseRepository.johnStartImagePath,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
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
                              _currentArtistName,
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
                          textAlign: TextAlign.left,
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
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
