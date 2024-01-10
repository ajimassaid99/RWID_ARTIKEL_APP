class TagModel {
  final int id;
  final String tag;

  const TagModel({required this.id, required this.tag});

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        id: json["tag_id"],
        tag: json["tag_name"],
      );
}
