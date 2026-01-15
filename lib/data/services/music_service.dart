import '../models/song_model.dart';

class MusicService {
  Future<List<SongModel>> getWeatherTunes(String mood) async {
    // TEMP: static demo data
    return [
      SongModel(
        title: 'Night Changes',
        artist: 'One Direction',
        imageUrl: 'https://i.scdn.co/image/ab67616d0000b273...',
        externalUrl: 'https://open.spotify.com/track/...',
      ),
    ];
  }
}