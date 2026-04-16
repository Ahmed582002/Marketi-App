import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/stripe/payment_manager.dart';
import 'package:store/features/Presentation/view/widgets/home/cart_product_card.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          final cart = state.cartProducts;

          if (cart.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          //! ================= TOTAL PRICE =================
          double totalPrice = 0;

          for (var item in cart) {
            totalPrice += item.price ?? 0;
          }

          return Column(
            children: [
              //! ================= LIST =================
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final product = cart[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Dismissible(
                        key: ValueKey(product.id),
                        direction: DismissDirection.endToStart,

                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        confirmDismiss: (direction) async {
                          return true;
                        },

                        onDismissed: (direction) async {
                          await cubit.removeFromCart(product.id!);

                          await cubit.refreshCart();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Item removed from cart ❌"),
                            ),
                          );
                        },

                        child: CartProductCard(
                          image: product.thumbnail ?? "",
                          title: product.title ?? "",
                          subtitle: product.category ?? "",
                          price: product.price ?? 0,
                          rating: product.rating ?? 0,
                          isFavorite: cubit.isFavorite(product.id!),
                          onFavoriteTap: () {
                            cubit.toggleFavorite(product.id!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Slide Left to remove the items",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),

              const SizedBox(height: 10),

              //! ================= CHECKOUT =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! total price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${totalPrice.toStringAsFixed(0)} EGP",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    //! checkout button
                    CustomButton(
                      text: "Checkout",
                      onPressed: () {
                        PaymentManager.makePayment(
                          (totalPrice + 1).toInt(),
                          "EGP",
                        );
                      },
                    ),
                  ],
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
