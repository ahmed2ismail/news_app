import 'package:flutter/material.dart';
import 'package:news_app/widgets/categories_list_view.dart';
import 'package:news_app/widgets/news_list_view_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'News',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Cloud',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body:
          // عندنا كذا طريقة نعمل بيها سكرول للصفحة كاملة
          // الطريقة الاولى عن طريق CustomScrollView
          CustomScrollView(
            // فقط NewsListView دي ليست بتعمل سكرول للصفحة بحالحا وليس لل
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: CategoriesListView()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              NewsListViewBuilder(category: "general",),
              // SliverToBoxAdapter(child: NewsListView()),
            ],
          ),
      // الطريقة الثانية عن طريق CustomScrollView
      // SingleChildScrollView(
      //   physics: const BouncingScrollPhysics(),
      //   child: Column(
      //     children: const [
      //       CategoriesListView(),
      //       SizedBox(height: 16),
      //       NewsListView(),
      //     ],
      //   ),
      // ),
      // الطريقة الثالثة مبتعملش سكرول للصفحة كاملة وهي دي Column + Expanded + ListView i built it in the file itself
      // Column(
      //   spacing: 16,
      //   children: const [
      //     CategoriesListView(),
      //     Expanded(child: NewsListView()),
      //   ],
      // ),
    );
  }
}
