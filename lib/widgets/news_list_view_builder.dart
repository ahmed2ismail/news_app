import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/news_list_view.dart';

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});

  final String category;
  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  // List<ArticleModel> articles = [];
  // ignore: prefer_typing_uninitialized_variables
  var future;
  @override
  void initState() {
    future = NewsService(Dio()).getTopHeadLines(category: widget.category);
    // كدا انا فصلت ال request عن ال  futureBuilder وبالتالي هيتبني مرة واحدة بس لانه بقي بره ال build method
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      // FutureBuilder: هو Widget بيستخدم لعرض البيانات اللي بتيجي من Future وبتعمل rebuild لل UI لما البيانات تجهز
      // لازم نمررله future و builder
      // future: بنحط ال request اللي هيجيلنا من المستقبل
      // builder: بنحط ال UI اللي هيظهرلنا لما ال request يكتمل
      // snapshot: هو ال object اللي هيحتوي على البيانات اللي هتيجي من ال future
      // snapshot.data: هي البيانات اللي هتيجي من ال future
      // snapshot.hasData: بتكون true لو في بيانات جايه من ال future
      // snapshot.hasError: بتكون true لو في error حصل في ال future
      // snapshot.connectionState: بيحدد حالة الاتصال بال future
      // ConnectionState.none: مفيش اتصال بال future
      // ConnectionState.waiting: في انتظار البيانات من ال future
      // ConnectionState.active: البيانات بتجيلنا من ال future
      // ConnectionState.done: البيانات وصلت من ال future
      future: future, // كتبنا ال request اللي هيجيلنا من المستقبل
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsListView(articles: snapshot.data!);
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(
            child: Center(child: Text("Oops , There was an error , Try Later")),
          );
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(
                context,
              ).size.height, // عشان ياخد ارتفاع الشاشة كلها
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blueAccent,
                    ),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(height: 12), // مسافة صغيرة بين اللودر والنص
                  Text(
                    "Loading News...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );

    // return isLoading
    //     ? SliverToBoxAdapter(
    //         child: Center(
    //           child: SizedBox(
    //             width: 40,
    //             height: 40,
    //             child: CircularProgressIndicator(
    //               strokeWidth: 4,
    //               valueColor: const AlwaysStoppedAnimation<Color>(
    //                 Colors.blueAccent,
    //               ),
    //               backgroundColor: Colors.grey[200],
    //             ),
    //           ),
    //         ),
    //       )
    //     : articles.isNotEmpty
    //     ? NewsListView(articles: articles)
    //     : SliverToBoxAdapter(
    //         child: Text("Oops , There was an error , Try Later"),
    //       );
  }
}
