import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/view/widgets/home/products_card.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeSuccess) {
          final favProducts = state.favoriteProducts;

          if (favProducts.isEmpty) {
            return const Center(child: Text("No Favorites Yet"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: favProducts.length,
            itemBuilder: (context, index) {
              final product = favProducts[index];

              return ProductCard(
                imagePath: product.thumbnail ?? "",
                category: product.category ?? "",
                title: product.title ?? "",
                price: product.price ?? 0,
                rating: product.rating ?? 0,
                isFavorite: true,
                onFavoriteTap: () {
                  cubit.toggleFavorite(product.id!);
                },
                onTap: () {
                  cubit.goToProductDetails(context, product.id!);
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
