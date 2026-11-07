part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.productLoaded() = ProductLoaded;
  const factory ProductEvent.productRefreshed() = ProductRefreshed;
  const factory ProductEvent.productDetailsfetched(int id) = ProductDetailsfetched;
}
