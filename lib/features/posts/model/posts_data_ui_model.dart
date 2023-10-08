// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class Blog {
  String id;
  String imageUrl;
  String title;

  Blog({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory Blog.fromMap(Map<String, dynamic> json) => Blog(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
      };
}
