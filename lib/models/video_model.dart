class Video {
  final String? videoId;
  final String title;
  final String description;
  final String thumbnailUrl;

  Video({
    this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      videoId: map['resourceId']['videoId'] ??"nana",
      title: map['title'],
      description: map['description'],
      thumbnailUrl: map['thumbnails']['high']['url'],
    );
  }
}
