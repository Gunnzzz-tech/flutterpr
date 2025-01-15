class Channel {
  final String id;
  final String title;
  final String description;
  final String uploadPlaylistId;
  final String thumbnailUrl;

  Channel({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadPlaylistId,
    required this.thumbnailUrl,
  });

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      description: map['snippet']['description'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
      thumbnailUrl: map['snippet']['thumbnails']['high']['url'],
    );
  }
}
