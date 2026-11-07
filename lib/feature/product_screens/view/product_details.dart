import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/extension.dart';
import 'package:flutter_application_1/feature/product_screens/model/products_model.dart';
import 'package:flutter_application_1/feature/product_screens/view_model/product_bloc/product_bloc.dart';
import 'package:flutter_application_1/feature/product_screens/widgets/circle_button.dart';
import 'package:flutter_application_1/feature/product_screens/widgets/information_row.dart';
import 'package:flutter_application_1/feature/product_screens/widgets/product_details_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _selectedImage = 0;
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductEvent.productDetailsfetched(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state.loadingStatus == LoadingStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.msg ?? 'An error occurred')));
          }
        },
        builder: (context, state) {
          print('ProductDetails state: ${state.products}');
          return SafeArea(
            child: state.loadingStatus == LoadingStatus.loading
                ? ProductDetailsShimmer()
                : state.loadingStatus == LoadingStatus.error
                ? Center(
                    child: Text(state.msg, style: const TextStyle(color: Colors.red)),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                          child: Row(
                            children: [
                              CircleButton(
                                icon: Icons.arrow_back_rounded,
                                onTap: () => Navigator.pop(context),
                              ),
                              const Spacer(),
                              const Text(
                                'PRODUCT DETAILS',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.1,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              const CircleButton(icon: Icons.favorite_border_rounded),
                            ],
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: state.product?.images.isEmpty ?? true
                                  ? const Center(child: Icon(Icons.image_outlined, size: 60))
                                  : Image.network(
                                      state.product!.images.first,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => const Center(
                                        child: Icon(Icons.image_not_supported_outlined, size: 50),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 78,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.product?.images.length ?? 0,
                            separatorBuilder: (_, __) => const SizedBox(width: 10),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => setState(() => _selectedImage = index),
                              child: Container(
                                width: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                    color: _selectedImage == index
                                        ? const Color(0xFF5B5FEF)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: Image.network(
                                    state.product!.images[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.image_outlined),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(22, 10, 22, 26),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.product?.category.toUpperCase() ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF5B5FEF),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  letterSpacing: 1.2,
                                ),
                              ),
                          8.height,
                              Text(
                                state.product?.title ?? '',
                                style: const TextStyle(
                                  fontSize: 25,
                                  height: 1.15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -.5,
                                ),
                              ),
                             10.height,
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: Color(0xFFFFB547),
                                    size: 19,
                                  ),
                                  Text(
                                    ' ${state.product?.rating.toStringAsFixed(1)}',
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    '  •  ${state.product?.stock} in stock',
                                    style: const TextStyle(color: Color(0xFF858597), fontSize: 12),
                                  ),
                                ],
                              ),
                              18.height,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${state.product?.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  10.width,
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F8EF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${state.product?.discountPercentage.toStringAsFixed(1)}% OFF',
                                      style: const TextStyle(
                                        color: Color(0xFF16834A),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              22.height,
                              const Text(
                                'Description',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                              8.height,
                              Text(
                                state.product?.description ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF777789),
                                  height: 1.55,
                                  fontSize: 13,
                                ),
                              ),
                              22.height,
                              const Text(
                                'Product information',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                              ),
                              12.height,
                              InfoRow(label: 'Brand', value: state.product?.brand ?? ''),
                              InfoRow(label: 'Category', value: state.product?.category ?? ''),
                              InfoRow(
                                label: 'Availability',
                                value: state.product?.stock != 0 ? 'In stock' : 'Out of stock',
                              ),
                              InfoRow(
                                label: 'Stock quantity',
                                value: '${state.product?.stock} units',
                              ),
                              24.height,
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: FilledButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.shopping_bag_outlined),
                                  label: const Text('Add to bag'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF5B5FEF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
