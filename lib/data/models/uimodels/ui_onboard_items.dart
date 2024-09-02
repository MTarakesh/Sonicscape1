// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UiOnBoardItems {
  final String image;
  final String title;

  UiOnBoardItems({
    required this.image,
    required this.title,
  });

  UiOnBoardItems copyWith({
    String? image,
    String? title,
    String? shortDescription,
  }) {
    return UiOnBoardItems(
      image: image ?? this.image,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
    };
  }

  factory UiOnBoardItems.fromMap(Map<String, dynamic> map) {
    return UiOnBoardItems(
      image: map['image'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UiOnBoardItems.fromJson(String source) =>
      UiOnBoardItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OnBoardItems(image: $image, title: $title, )';

  @override
  bool operator ==(covariant UiOnBoardItems other) {
    if (identical(this, other)) return true;

    return other.image == image && other.title == title;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode;
}
