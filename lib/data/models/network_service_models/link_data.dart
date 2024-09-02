import 'package:json_annotation/json_annotation.dart';

part 'link_data.g.dart';

@JsonSerializable()
class LinkData {
  final String? image;
  final String? file;
  LinkData({
    this.image,
    this.file,
  });

  LinkData copyWith({
    String? image,
    String? file,
  }) {
    return LinkData(
      image: image ?? this.image,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'file': file,
    };
  }

  factory LinkData.fromMap(Map<String, dynamic> map) {
    return LinkData(
      image: map['image'] != null ? map['image'] as String : null,
      file: map['file'] != null ? map['file'] as String : null,
    );
  }

  factory LinkData.fromJson(Map<String, dynamic> json) =>
      _$LinkDataFromJson(json);
  Map<String, dynamic> toJson() => _$LinkDataToJson(this);
  @override
  String toString() => 'LinkData(image: $image, file: $file)';

  @override
  bool operator ==(covariant LinkData other) {
    if (identical(this, other)) return true;

    return other.image == image && other.file == file;
  }

  @override
  int get hashCode => image.hashCode ^ file.hashCode;
}
