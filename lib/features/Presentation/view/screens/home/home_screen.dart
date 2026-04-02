import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/view/widgets/home/products_card.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/home_state.dart';
import 'package:store/features/Presentation/view/widgets/home/navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            //! ================= LOADING =================
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            //! ================= ERROR =================
            if (state is HomeError) {
              return Center(child: Text(state.message));
            }

            //! ================= SUCCESS =================
            if (state is HomeSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  //! ========== Categories ==========
                  SizedBox(
                    height: 80,
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
                                radius: 25,
                                backgroundImage: NetworkImage(cat.image),
                              ),
                              const SizedBox(height: 5),
                              Text(cat.name),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  //! ========== Products ==========
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];

                        return ProductCard(
                          imagePath: "assets/images/product.png", // 👈 مؤقت
                          category: product.category ?? "",
                          title: product.title ?? "",
                          price: product.price ?? 0,
                          rating: product.rating ?? 0,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),

      //! ================= Bottom Nav =================
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: cubit.currentIndex,
        onTap: (index) {
          cubit.changeBottomNav(index);
        },
      ),
    );
  }
}
