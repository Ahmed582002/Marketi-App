import 'package:flutter/material.dart';
import 'package:store/features/data/models/home/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoriesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final cat = categories[index];

          return Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(cat.image ?? ""),
              ),
              const SizedBox(height: 10),
              Text(cat.name ?? ""),
            ],
          );
        },
      ),
    );
  }
}
