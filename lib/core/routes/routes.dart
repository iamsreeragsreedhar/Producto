import 'package:flutter_application_1/feature/product_screens/view/product_details.dart';
import 'package:flutter_application_1/feature/product_screens/view/product_listing.dart';
import 'package:flutter_application_1/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String ProductdetailScreen = '/productdetail/:id';
  //   static const String registerScreen = '/register';
}

final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppRoutes.homeScreen, builder: (context, state) => const ProductListing()),
    GoRoute(
      path: AppRoutes.ProductdetailScreen,
      name: 'productdetail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);

        return ProductDetails(id: id);
      },
    ),
    // GoRoute(
    //   path: AppRoutes.ProductdetailScreen,
    //   builder: (context, state) => const ProductDetailScreen(),
    // ),
  ],
);
