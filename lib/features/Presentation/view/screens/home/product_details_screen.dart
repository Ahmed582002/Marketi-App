import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              padding: const EdgeInsets.all(16),
              children: [
                Image.network(product.thumbnail ?? ""),

                const SizedBox(height: 20),

                Text(
                  product.title ?? "",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(product.description ?? ""),

                const SizedBox(height: 20),

                Text(
                  "${product.price} LE",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
