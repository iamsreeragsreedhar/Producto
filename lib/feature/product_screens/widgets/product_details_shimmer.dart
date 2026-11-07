import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/extension.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 250, width: double.infinity, color: Colors.white),
            20.height,
            Container(height: 20, width: 200, color: Colors.white),
            12.height,
            Container(height: 15, width: 100, color: Colors.white),
            20.height,
            Container(height: 15, width: double.infinity, color: Colors.white),
            10.height,
            Container(height: 15, width: 250, color: Colors.white),
            25.height,
            Container(height: 50, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
