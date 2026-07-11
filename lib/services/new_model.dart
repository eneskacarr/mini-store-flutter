class NewModel {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String category;
  final String author;
  final String image;
  final String publishedAt;

  NewModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.category,
    required this.author,
    required this.image,
    required this.publishedAt,
  });

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      summary: json['summary'] ?? "",
      content: json['content'] ?? "",
      category: json['category'] ?? "",
      author: json['author'] ?? "",
      image: json['image'] ?? "",
      publishedAt: json['published_at'] ?? "",
    );
  }
}