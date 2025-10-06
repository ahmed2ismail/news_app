import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/models/category_model.dart';
import 'category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
  });

  final List<CategoryModel> categories = const [
    CategoryModel(
      image: 'assets/general.jpg',
      categoryName: 'General',
    ),
    CategoryModel(
      image: 'assets/business.jpg',
      categoryName: 'Business',
    ),
    CategoryModel(
      image: 'assets/entertainment.png',
      categoryName: 'Entertainment',
    ),
    CategoryModel(
      image: 'assets/science.png',
      categoryName: 'Science',
    ),
    CategoryModel(
      image: 'assets/technology.jpg',
      categoryName: 'Technology',
    ),
    CategoryModel(
      image: 'assets/health.png',
      categoryName: 'Health',
    ),
    CategoryModel(
      image: 'assets/sports.jpg',
      categoryName: 'Sports',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 95,
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index],);
            },
          ),
        ),
      );
  }
}
