class BookmarkModel {
  final int id;
  final int userId;
  final int artikelId;

  const BookmarkModel({required this.id, required this.userId, required this.artikelId});

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        id: json["id"],
        userId: json["user_id"],
        artikelId: json["artikel_id"]
      );
}
