// Import necessary packages
import 'dart:convert';

class VideoData {
  final String videoUrl;
  final String title;
  final String thumbnail;

  VideoData({required this.videoUrl, required this.title, required this.thumbnail});

  // Convert JSON to VideoData object
  factory VideoData.fromJson(Map<String, dynamic> json) {
    return VideoData(
      videoUrl: json['videoUrl'],
      title: json['title'],
      thumbnail: json['thumbnail'],
    );
  }

  // Example mock JSON data
  static List<VideoData> getMockData() {
    final String jsonString = '''
      [
        {
          "videoUrl": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
          "title": "Never gonna give you up song",
          "thumbnail": "https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg"
        },
        {
          "videoUrl": "https://www.youtube.com/watch?v=3JZ_D3ELwOQ",
          "title": "Exploring Flutter Widgets",
          "thumbnail": "https://img.youtube.com/vi/3JZ_D3ELwOQ/0.jpg"
        },
        {
          "videoUrl": "https://www.youtube.com/watch?v=LXb3EKWsInQ",
          "title": "Uptown Funk",
          "thumbnail": "https://img.youtube.com/vi/LXb3EKWsInQ/0.jpg"
        }
        
      ]
    ''';

    // Parse JSON string and convert it into a list of VideoData
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((data) => VideoData.fromJson(data)).toList();
  }
}
