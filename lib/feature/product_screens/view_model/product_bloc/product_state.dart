part of 'product_bloc.dart';

enum type { none, productlist, refresh, offline, productdetails, search }

enum LoadingStatus { none, loading, success, error }

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    @Default(type.none) type authtype,
    @Default(LoadingStatus.none) LoadingStatus loadingStatus,
    @Default('') String msg,
    @Default([]) List<Product> products,
    Product? product,
    @Default(false) bool isOffline,
  }) = _productState;
}
