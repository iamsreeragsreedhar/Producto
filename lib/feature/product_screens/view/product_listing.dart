import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/routes/routes.dart';
import 'package:flutter_application_1/core/widgets/extension.dart';
import 'package:flutter_application_1/feature/product_screens/view_model/product_bloc/product_bloc.dart';
import 'package:flutter_application_1/feature/product_screens/widgets/product_card.dart';
import 'package:flutter_application_1/feature/product_screens/widgets/shimmer_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({super.key});

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductEvent.productLoaded());
    debugPrint('ProductLoaded event completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(ProductEvent.productLoaded());
        },

        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.loadingStatus == LoadingStatus.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.msg ?? 'An error occurred')));
            }

            if (state.loadingStatus == LoadingStatus.success) {
              debugPrint('ProductLoaded event completed successfully');
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5B5FEF),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.shopping_bag_rounded, color: Colors.white),
                              ),
                              11.width,
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PRODUCTO',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Discover something new',
                                    style: TextStyle(color: Color(0xFF858597), fontSize: 11),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(Icons.notifications_none_rounded),
                              //   style: IconButton.styleFrom(backgroundColor: Colors.white),
                              // ),
                            ],
                          ),
                          28.height,
                          const Text(
                            'Find your\nfavorites.',
                            style: TextStyle(
                              fontSize: 31,
                              height: 1.12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -.8,
                            ),
                          ),
                          18.height,
                          TextField(
                            onChanged: (value) {
                              context.read<ProductBloc>().add(ProductEvent.productsearched(value));
                            },
                            decoration: InputDecoration(
                              hintText: 'Search products',
                              prefixIcon: const Icon(Icons.search_rounded),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          22.height,
                          const Row(
                            children: [
                              Text(
                                'Popular products',
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                              ),
                              Spacer(),
                              Text(
                                'Explore all',
                                style: TextStyle(
                                  color: Color(0xFF5B5FEF),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          5.height,
                          const Text(
                            'Handpicked items for you',
                            style: TextStyle(color: Color(0xFF858597), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  (state.loadingStatus == LoadingStatus.loading)
                      ? SliverToBoxAdapter(child: ProductShimmer())
                      : SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: .70,
                            ),
                            delegate: SliverChildBuilderDelegate((context, index) {
                              final product = state.products[index];
                              return ProductCard(
                                product: product,
                                onTap: () {
                                  context.pushNamed(
                                    'productdetail',
                                    pathParameters: {'id': product.id.toString()},
                                  );
                                },
                              );
                            }, childCount: state.products.length),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
