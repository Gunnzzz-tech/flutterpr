import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:newpr/models/chanel_model.dart';
import 'package:newpr/models/video_model.dart';
import 'package:newpr/utils/key.dart';

class APIService {
  static const String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  // Fetch channel details by channel ID
  Future<Channel> fetchChannel({required String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': channelId,
      'key': API_KEY, // Replace with your YouTube Data API key
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      return Channel.fromMap(data);
    } else {
      final errorMessage = json.decode(response.body)['error']['message'];
      throw Exception('Failed to fetch channel: $errorMessage');
    }
  }

  // Fetch videos from a playlist by playlist ID
  Future<List<Video>> fetchVideosFromPlaylist({required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '20', // Fetch up to 20 results per request
      'pageToken': _nextPageToken, // Handle pagination if needed
      'key': API_KEY, // Replace with your YouTube Data API key
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Update nextPageToken for subsequent calls
      _nextPageToken = data['nextPageToken'] ?? '';

      // Extract videos from response
      List<dynamic> videosJson = data['items'] ?? [];
      List<Video> videos = videosJson.map((videoJson) {
        // Safely extract snippet
        final snippet = videoJson['snippet'];
        if (snippet != null) {
          return Video.fromMap(snippet);
        } else {
          throw Exception('Malformed video data: Missing snippet.');
        }
      }).toList();

      return videos;
    } else {
      final errorMessage = json.decode(response.body)['error']['message'];
      throw Exception('Failed to fetch videos: $errorMessage');
    }
  }
}
