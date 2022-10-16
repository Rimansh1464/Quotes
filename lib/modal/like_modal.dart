import 'dart:convert';

List<Like> likeFromJson(String str) =>
    List<Like>.from(json.decode(str).map((x) => Like.database(data: x)));

List<Like> likeJson(String str) =>
    List<Like>.from(json.decode(str).map((x) => Like.fromMap(data: x)));

class Like {
  int? id;
  String? quote;
  String? image;

  Like({
    this.id,
    required this.quote,
    this.image,
  });

  factory Like.fromMap({required Map data}) {
    return Like(
      quote: data["quote"],
    );
  }

  factory Like.database({required Map data}) {
    return Like(
      id: data["id"],
      quote: data["quote"],
      image: data["image"],
    );
  }
}
