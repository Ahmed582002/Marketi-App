import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/product_details_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/product_details_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                // images
                Image.network(product.thumbnail ?? "", height: 230),
                const SizedBox(height: 5),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.images!.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(product.images![index]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.category ?? "",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 14),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.text,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${product.rating}",
                            style: TextStyle(color: AppColors.secondary),
                          ),
                          SizedBox(width: 4),
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  product.title ?? "",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "${product.price} EGP",
                  style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Description",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.headText,
                  ),
                ),
                const SizedBox(height: 10),
                Text(product.description ?? ""),
                const SizedBox(height: 10),
                CustomButton(
                  text: "Add To Cart",
                  onPressed: () async {
                    final homeCubit = context.read<HomeCubit>();

                    await homeCubit.toggleCart(product.id!);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Added to cart ✅")));
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
