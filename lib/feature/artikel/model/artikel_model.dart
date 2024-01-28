class ArtikelModel {
  final int id;
  final String author;
  final String authorProfile;
  final String title;
  final String urlImage;
  final String content;
  final String createdAt;

  ArtikelModel(
      {required this.id,
      required this.author,
      required this.authorProfile,
      required this.title,
      required this.urlImage,
      required this.createdAt,
      required this.content});

  factory ArtikelModel.fromJson(Map<String, dynamic> json) => ArtikelModel(
      author: json["author"]["nama"] ?? '',
      id: json["id"] ?? 0,
      title: json['title'] ?? '',
      urlImage: json['url_image'] ?? '',
      content: json['content'] ?? '',
      createdAt: json['created_at'] ?? '',
      authorProfile: json["author"]["url_image"]??"" );
}
