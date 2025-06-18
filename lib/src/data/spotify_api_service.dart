import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math'; // Für die Zufallsauswahl eines Albums

/// Ein Service, der alle Interaktionen mit der Spotify API kapselt.
class SpotifyApiService {
  final String _clientId;
  final String _clientSecret;
  String? _accessToken; // Der Access Token wird hier verwaltet

  SpotifyApiService({required String clientId, required String clientSecret})
    : _clientId = clientId,
      _clientSecret = clientSecret;

  /// Ruft einen neuen Spotify Access Token ab.
  /// Gibt den Access Token bei Erfolg zurück, null bei Fehler.
  Future<String?> getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$_clientId:$_clientSecret'))}',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];
      return _accessToken;
    } else {
      // Fehlerbehandlung kann hier detaillierter sein (z.B. Loggen)
      throw Exception(
        'Failed to get access token: ${response.statusCode} - ${response.body}',
      );
    }
  }

  /// Sucht nach einem Künstler anhand seines Namens und gibt dessen ID zurück.
  /// Gibt die Künstler-ID bei Erfolg zurück, null wenn nicht gefunden oder Fehler.
  Future<String?> searchArtistId(String artistName) async {
    if (_accessToken == null) {
      await getAccessToken(); // Versuche, einen Token abzurufen, falls nicht vorhanden
      if (_accessToken == null) return null;
    }

    final response = await http.get(
      Uri.parse(
        'https://api.spotify.com/v1/search?q=${Uri.encodeQueryComponent(artistName)}&type=artist&limit=1',
      ),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final artists = data['artists']['items'] as List;
      if (artists.isNotEmpty) {
        return artists[0]['id'] as String;
      }
      return null;
    } else if (response.statusCode == 401) {
      // Token abgelaufen, versuche neuen Token zu bekommen und Anruf zu wiederholen
      await getAccessToken();
      if (_accessToken != null) {
        return searchArtistId(artistName); // Rekursiver Aufruf
      }
      throw Exception('Unauthorized. Failed to refresh token.');
    } else {
      throw Exception(
        'Failed to search artist: ${response.statusCode} - ${response.body}',
      );
    }
  }

  /// Ruft eine zufällige Auswahl von Alben für eine gegebene Künstler-ID ab.
  /// Gibt ein Map mit Albumdetails zurück (Name, Releasedatum, Cover-URL, Spotify-URL).
  /// Gibt null zurück, wenn keine Alben gefunden wurden oder ein Fehler auftrat.
  Future<Map<String, dynamic>?> fetchRandomAlbumForArtistId(
    String artistId,
  ) async {
    if (_accessToken == null) {
      await getAccessToken(); // Versuche, einen Token abzurufen, falls nicht vorhanden
      if (_accessToken == null) return null;
    }

    final response = await http.get(
      Uri.parse(
        'https://api.spotify.com/v1/artists/$artistId/albums?limit=50&include_groups=album,single',
      ),
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic>? albums = data['items'];

      if (albums != null && albums.isNotEmpty) {
        final List<Map<String, dynamic>> validAlbums = albums
            .whereType<Map<String, dynamic>>()
            .where(
              (album) =>
                  (album['images'] as List<dynamic>?)?.isNotEmpty == true &&
                  album['name'] != null &&
                  album['release_date'] != null,
            )
            .toList();

        if (validAlbums.isNotEmpty) {
          final Map<String, dynamic> selectedAlbum =
              validAlbums[Random().nextInt(validAlbums.length)];

          final List<dynamic>? images = selectedAlbum['images'];
          String imageUrl =
              'https://placehold.co/150x150/cccccc/ffffff?text=Kein+Cover';
          if (images != null && images.isNotEmpty) {
            imageUrl = images.first['url'] as String;
          }

          return {
            'name': selectedAlbum['name'],
            'release_date': selectedAlbum['release_date'],
            'cover_art_url': imageUrl,
            'spotify_url':
                (selectedAlbum['external_urls']
                    as Map<String, dynamic>?)?['spotify'],
          };
        }
      }
      return null;
    } else if (response.statusCode == 401) {
      // Token abgelaufen, versuche neuen Token zu bekommen und Anruf zu wiederholen
      await getAccessToken();
      if (_accessToken != null) {
        return fetchRandomAlbumForArtistId(artistId); // Rekursiver Aufruf
      }
      throw Exception('Unauthorized. Failed to refresh token.');
    } else {
      throw Exception(
        'Failed to fetch albums: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
