class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String? url;

  ArticleModel({
    required this.url,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'],
      title: json['title'] ?? 'No Title',
      subTitle: json['description'],
      url: json['url'], // 👈 ده هو اللينك اللي بيجي من الـ API
    );
  }
}
