class ArticleModel {
  final String uid;
  final String title;
  final String? coverImg;
  final String content;
  final String author;
  final String? authorImg;
  final DateTime createdAt;
  final String authorUid;
  bool isFavorite;
  String? image;
  String? categoryTitle;

  final String category;

  ArticleModel({
    required this.uid,
    required this.title,
    this.coverImg,
    required this.content,
    required this.author,
    required this.authorImg,
    required this.createdAt,
    required this.authorUid,
    required this.isFavorite,
    this.image,
    this.categoryTitle,
    required this.category,
  });

  ArticleModel copyWith({
    String? uid,
    String? title,
    String? coverImg,
    String? content,
    String? author,
    String? authorImg,
    DateTime? createdAt,
    String? authorUid,
    bool? isFavorite,
    String? image,
    String? categoryTitle,
    String? category,
  }) {
    return ArticleModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      coverImg: coverImg ?? this.coverImg,
      content: content ?? this.content,
      author: author ?? this.author,
      authorImg: authorImg ?? this.authorImg,
      createdAt: createdAt ?? this.createdAt,
      authorUid: authorUid ?? this.authorUid,
      isFavorite: isFavorite ?? this.isFavorite,
      image: image ?? this.image,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'coverImg': coverImg,
      'content': content,
      'author': author,
      'authorImg': authorImg,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'authorUid': authorUid,
      'isFavorite': isFavorite,
      'image': image,
      'categoryTitle': categoryTitle,
      'category': category,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      coverImg: map['coverImg'] != null ? map['coverImg'] as String : null,
      content: map['content'] as String,
      author: map['author'] as String,
      authorImg: map['authorImg'] != null ? map['authorImg'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      authorUid: map['authorUid'] as String,
      isFavorite: map['isFavorite'] as bool,
      image: map['image'] != null ? map['image'] as String : null,
      categoryTitle:
          map['categoryTitle'] != null ? map['categoryTitle'] as String : null,
      category: map['category'] as String,
    );
  }

  @override
  String toString() {
    return 'ArticleModel(uid: $uid, title: $title, coverImg: $coverImg, content: $content, author: $author, authorImg: $authorImg, createdAt: $createdAt, authorUid: $authorUid, isFavorite: $isFavorite, image: $image, categoryTitle: $categoryTitle, category: $category)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.coverImg == coverImg &&
        other.content == content &&
        other.author == author &&
        other.authorImg == authorImg &&
        other.createdAt == createdAt &&
        other.authorUid == authorUid &&
        other.isFavorite == isFavorite &&
        other.image == image &&
        other.categoryTitle == categoryTitle &&
        other.category == category;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        coverImg.hashCode ^
        content.hashCode ^
        author.hashCode ^
        authorImg.hashCode ^
        createdAt.hashCode ^
        authorUid.hashCode ^
        isFavorite.hashCode ^
        image.hashCode ^
        categoryTitle.hashCode ^
        category.hashCode;
  }
}
