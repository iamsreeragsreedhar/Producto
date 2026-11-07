import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network_service/local_storage.dart';
import 'package:flutter_application_1/core/network_service/network_service.dart';
import 'package:flutter_application_1/core/repository/dio_client.dart';
import 'package:flutter_application_1/feature/product_screens/model/products_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DioClient client;
  final ProductLocalStorage localstorage;
  final NetworkService service;
  ProductBloc(this.client, {required this.localstorage, required this.service})
    : super(ProductState()) {
    on<ProductLoaded>(productListing);
    on<ProductDetailsfetched>(fetchProductDetails);
    on<ProductSearched>(searchProducts);
  }

  Future<void> productListing(ProductLoaded event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));

    try {
      final isConnected = await service.isConnected();
      if (isConnected) {
        log("Internet connection available. Fetching latest data.");
        final response = await client.get(endpoint: '/products');
        final products = (response.data['products'] as List<dynamic>)
            .map((json) => Product.fromJson(json))
            .toList();

        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.productlist,
            products: products,
          ),
        );
        final cachedProducts = await localstorage.getProducts();
        if (cachedProducts.isEmpty) {
          await localstorage.saveProducts(products);
        }
      } else {
        final cachedProducts = await localstorage.getProducts();

        if (cachedProducts.isNotEmpty) {
          emit(
            state.copyWith(
              loadingStatus: LoadingStatus.success,
              authtype: type.offline,
              products: cachedProducts,
              msg: 'No internet connection. Showing cached data.',
              isOffline: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              loadingStatus: LoadingStatus.error,
              authtype: type.offline,
              products: [],
              msg: 'No internet connection and no cached products available.',
              isOffline: true,
            ),
          );
        }
      }
    } catch (e) {
      final cachedProducts = await localstorage.getProducts();
      if (cachedProducts.isNotEmpty) {
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.offline,
            products: cachedProducts,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.error,
            msg: 'Unable to load products. Please try again.',
            authtype: type.offline,
          ),
        );
      }
    }
  }

  Future<void> fetchProductDetails(ProductDetailsfetched event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading, msg: ''));

    try {
      final isConnected = await service.isConnected();
      if (isConnected) {
        final response = await client.get(endpoint: '/products/${event.id}');
        final product = Product.fromJson(response.data);

        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.productdetails,
            product: product,
          ),
        );
      } else {
        final cachedProducts = await localstorage.getProducts();
        final product = cachedProducts.firstWhere((element) => element.id == event.id);

        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.offline,
            product: product,
          ),
        );
      }
    } catch (e) {
      try {
        final cachedProducts = await localstorage.getProducts();
        final product = cachedProducts.firstWhere((element) => element.id == event.id);
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.offline,
            product: product,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.error,
            msg: 'Product details are not available offline.',
            authtype: type.offline,
          ),
        );
      }
    }
  }

  Future<void> searchProducts(ProductSearched event, Emitter<ProductState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading, msg: ''));

    try {
      final isConnected = await service.isConnected();
      if (isConnected) {
        final response = await client.get(endpoint: '/products');
        final products = (response.data['products'] as List<dynamic>)
            .map((json) => Product.fromJson(json))
            .toList();

        final filteredProducts = products
            .where((product) => product.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.search,
            products: filteredProducts,
          ),
        );
      } else {
        final cachedProducts = await localstorage.getProducts();
        final filteredProducts = cachedProducts
            .where((product) => product.title.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        emit(
          state.copyWith(
            loadingStatus: LoadingStatus.success,
            authtype: type.search,
            products: filteredProducts,
            msg: 'No internet connection. Showing cached data.',
            isOffline: true,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          msg: 'Unable to search products. Please try again.',
          authtype: type.search,
        ),
      );
    }
  }
}
