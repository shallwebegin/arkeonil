class ArchaeCategory {
  final String image;
  final String title;
  final String uid;
  ArchaeCategory({
    required this.image,
    required this.title,
    required this.uid,
  });

  ArchaeCategory copyWith({
    String? image,
    String? title,
    String? uid,
  }) {
    return ArchaeCategory(
      image: image ?? this.image,
      title: title ?? this.title,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'uid': uid,
    };
  }

  factory ArchaeCategory.fromMap(Map<String, dynamic> map) {
    return ArchaeCategory(
      image: map['image'] as String,
      title: map['title'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() =>
      'ArchaeCategory(image: $image, title: $title, uid: $uid)';

  @override
  bool operator ==(covariant ArchaeCategory other) {
    if (identical(this, other)) return true;

    return other.image == image && other.title == title && other.uid == uid;
  }

  @override
  int get hashCode => image.hashCode ^ title.hashCode ^ uid.hashCode;
}
