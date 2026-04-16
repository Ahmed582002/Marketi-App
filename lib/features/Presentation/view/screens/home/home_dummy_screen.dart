import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/view/widgets/home/custom_search_bar.dart';
import 'package:store/features/Presentation/view/widgets/home/products_card.dart';
import 'package:store/features/Presentation/view/widgets/home/see_more.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_dummy_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_dummy_state.dart';

class HomeDummyScreen extends StatelessWidget {
  const HomeDummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Hi Ahmed!',
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Discover your next masterpiece',
            style: Theme.of(
              context,
            ).textTheme.displayMedium!.copyWith(fontSize: 18),
          ),
        ),
        const SizedBox(height: 15),
        // Search Bar
        CustomSearchBar(
          controller: TextEditingController(),
          text: "Products",
          onChanged: (value) {},
          onFilterTap: () {},
        ),
        const SizedBox(height: 30),
        SeeMore(text: "Products", onTap: () {}),
        // products
        BlocProvider(
          create: (context) => HomeDummyCubit()..getProducts(),
          child: BlocBuilder<HomeDummyCubit, HomeDummyState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeSuccess) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return ProductCard(
                      imagePath: product["thumbnail"],
                      category: product["category"],
                      title: product["title"],
                      price: product["price"],
                      rating: product["rating"],
                    );
                  },
                );
              }

              if (state is HomeError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
