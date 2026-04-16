import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/features/Presentation/view/widgets/home/custom_search_bar.dart';
import 'package:store/features/Presentation/view/widgets/home/home_shimmer.dart';
import 'package:store/features/Presentation/view/widgets/home/products_card.dart';
import 'package:store/features/Presentation/view/widgets/home/see_more.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        //! ================= LOADING =================
        if (state is HomeLoading) {
          return const HomeShimmer();
        }

        //! ================= ERROR =================
        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        //! ================= SUCCESS =================
        if (state is HomeSuccess) {
          return ListView(
            children: [
              const SizedBox(height: 10),

              //! ========== Header ==========
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

              //! ========== Search ==========
              CustomSearchBar(
                controller: cubit.searchController,
                text: "Products",
                onChanged: cubit.onSearchChanged,
                onFilterTap: () {},
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset("assets/images/Offers.png"),
              ),

              const SizedBox(height: 20),

              //! ========== Categories ==========
              SeeMore(
                text: "Categories",
                onTap: () {
                  context.read<HomeCubit>().goToCategories(
                    context,
                    state.categories,
                  );
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final cat = state.categories[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(cat.image ?? ""),
                          ),
                          const SizedBox(height: 5),
                          Text(cat.name ?? ""),
                        ],
                      ),
                    );
                  },
                ),
              ),

              //! ========== Products ==========
              const SizedBox(height: 30),

              SeeMore(text: "Products", onTap: () {}),

              const SizedBox(height: 10),

              NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    cubit.loadMore();
                  }
                  return false;
                },
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return ProductCard(
                      imagePath: product.thumbnail ?? "",
                      category: product.category ?? "",
                      title: product.title ?? "",
                      price: product.price ?? 0,
                      rating: product.rating ?? 0,
                      isFavorite: cubit.isFavorite(product.id!),
                      onFavoriteTap: () {
                        cubit.toggleFavorite(product.id!);
                      },
                      onTap: () {
                        cubit.goToProductDetails(context, product.id!);
                      },
                    );
                  },
                ),
              ),

              //! ========== Brands ==========
              const SizedBox(height: 20),

              SeeMore(
                text: "Brands",
                onTap: () {
                  context.read<HomeCubit>().goToBrands(context, state.brands);
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.brands.length,
                  itemBuilder: (context, index) {
                    final brand = state.brands[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.text,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 55,
                            width: 55,
                            child: Center(
                              child: Text(
                                brand.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(brand.name ?? ""),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
