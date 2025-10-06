import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);

  Future<List<ArticleModel>> getTopHeadLines({required String category}) async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?apiKey=51a30b01506a4623835a54e2b6fde2a3&country=us&category=$category',
      );
      // jsonData => بتمثل البيانات اللي جايه من ال API واللي هي عبارة عن List of articles وموجودة جوه ال response.data
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];
      List<ArticleModel> articleList = [];
      for (var article in articles) {
        // مبقناش بنعمل كدا عشان عملنا factory constructor جوه ال ArticleModel
        ArticleModel articleModel = ArticleModel.fromJson(article);
        // بدل ما نعمل كدا
        // ArticleModel articleModel = ArticleModel(
        //   image: article["urlToImage"],
        //   title: article["title"],
        //   subTitle: article["description"],
        // );
        articleList.add(articleModel);
      }
      return articleList;
    } on Exception catch (e) {
      return "There was an error $e" as List<ArticleModel>;
    }
  }
}
