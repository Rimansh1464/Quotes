import 'dart:convert';

List<Quotes> quotesFromJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.database(data: x)));

List<Quotes> quotesJson(String str) =>
    List<Quotes>.from(json.decode(str).map((x) => Quotes.fromMap(data: x)));

class Quotes {
  String? quote;
  String? author;
  String? category;
  // String? like;
  String? image;

  Quotes({
    required this.quote,
    required this.author,
    required this.category,
    this.image,
  });

  factory Quotes.fromMap({required Map data}) {
    return Quotes(
      quote: data["quote"],
      author: data["author"]?? "25 km/h",
      category: data["category"] ?? "25 km/h",
    );
  }

  factory Quotes.database({required Map data}) {
    return Quotes(
      quote: data["quote"],
      image: data["image"],
      author: data["author"],
      category: data["category"],

    );
  }
}
