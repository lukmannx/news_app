class Article {
  String author;
  String title;
  String content;
  String urlToImage;
  String publishedAt;

  Article({
      required this.author,
      required this.content,
      required this.title,
      required this.urlToImage,
      required this.publishedAt
  });

  //! memetakan json object ke model
  factory Article.fromJson(Map<String, dynamic> json ) => Article(
    title: json["title"] ?? "Null",
    author: json["author"] ?? "Null",
    content: json["content"] ?? "Null",
    publishedAt: json["publishedAt"] ?? "Null",
    urlToImage: json["urlToImage"] ?? "https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png",
  );
}