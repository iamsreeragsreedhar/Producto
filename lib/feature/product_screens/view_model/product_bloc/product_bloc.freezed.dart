// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent()';
}


}

/// @nodoc
class $ProductEventCopyWith<$Res>  {
$ProductEventCopyWith(ProductEvent _, $Res Function(ProductEvent) __);
}


/// @nodoc


class ProductLoaded implements ProductEvent {
  const ProductLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent.productLoaded()';
}


}




/// @nodoc


class ProductRefreshed implements ProductEvent {
  const ProductRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent.productRefreshed()';
}


}




/// @nodoc


class ProductDetailsfetched implements ProductEvent {
  const ProductDetailsfetched(this.id);
  

 final  int id;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsfetchedCopyWith<ProductDetailsfetched> get copyWith => _$ProductDetailsfetchedCopyWithImpl<ProductDetailsfetched>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsfetched&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProductEvent.productDetailsfetched(id: $id)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsfetchedCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory $ProductDetailsfetchedCopyWith(ProductDetailsfetched value, $Res Function(ProductDetailsfetched) _then) = _$ProductDetailsfetchedCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$ProductDetailsfetchedCopyWithImpl<$Res>
    implements $ProductDetailsfetchedCopyWith<$Res> {
  _$ProductDetailsfetchedCopyWithImpl(this._self, this._then);

  final ProductDetailsfetched _self;
  final $Res Function(ProductDetailsfetched) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(ProductDetailsfetched(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ProductState {

 type get authtype; LoadingStatus get loadingStatus; String get msg; List<Product> get products; Product? get product; bool get isOffline;
/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateCopyWith<ProductState> get copyWith => _$ProductStateCopyWithImpl<ProductState>(this as ProductState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState&&(identical(other.authtype, authtype) || other.authtype == authtype)&&(identical(other.loadingStatus, loadingStatus) || other.loadingStatus == loadingStatus)&&(identical(other.msg, msg) || other.msg == msg)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.product, product) || other.product == product)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline));
}


@override
int get hashCode => Object.hash(runtimeType,authtype,loadingStatus,msg,const DeepCollectionEquality().hash(products),product,isOffline);

@override
String toString() {
  return 'ProductState(authtype: $authtype, loadingStatus: $loadingStatus, msg: $msg, products: $products, product: $product, isOffline: $isOffline)';
}


}

/// @nodoc
abstract mixin class $ProductStateCopyWith<$Res>  {
  factory $ProductStateCopyWith(ProductState value, $Res Function(ProductState) _then) = _$ProductStateCopyWithImpl;
@useResult
$Res call({
 type authtype, LoadingStatus loadingStatus, String msg, List<Product> products, Product? product, bool isOffline
});




}
/// @nodoc
class _$ProductStateCopyWithImpl<$Res>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._self, this._then);

  final ProductState _self;
  final $Res Function(ProductState) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authtype = null,Object? loadingStatus = null,Object? msg = null,Object? products = null,Object? product = freezed,Object? isOffline = null,}) {
  return _then(_self.copyWith(
authtype: null == authtype ? _self.authtype : authtype // ignore: cast_nullable_to_non_nullable
as type,loadingStatus: null == loadingStatus ? _self.loadingStatus : loadingStatus // ignore: cast_nullable_to_non_nullable
as LoadingStatus,msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _productState implements ProductState {
  const _productState({this.authtype = type.none, this.loadingStatus = LoadingStatus.none, this.msg = '', final  List<Product> products = const [], this.product, this.isOffline = false}): _products = products;
  

@override@JsonKey() final  type authtype;
@override@JsonKey() final  LoadingStatus loadingStatus;
@override@JsonKey() final  String msg;
 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  Product? product;
@override@JsonKey() final  bool isOffline;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$productStateCopyWith<_productState> get copyWith => __$productStateCopyWithImpl<_productState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _productState&&(identical(other.authtype, authtype) || other.authtype == authtype)&&(identical(other.loadingStatus, loadingStatus) || other.loadingStatus == loadingStatus)&&(identical(other.msg, msg) || other.msg == msg)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.product, product) || other.product == product)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline));
}


@override
int get hashCode => Object.hash(runtimeType,authtype,loadingStatus,msg,const DeepCollectionEquality().hash(_products),product,isOffline);

@override
String toString() {
  return 'ProductState(authtype: $authtype, loadingStatus: $loadingStatus, msg: $msg, products: $products, product: $product, isOffline: $isOffline)';
}


}

/// @nodoc
abstract mixin class _$productStateCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$productStateCopyWith(_productState value, $Res Function(_productState) _then) = __$productStateCopyWithImpl;
@override @useResult
$Res call({
 type authtype, LoadingStatus loadingStatus, String msg, List<Product> products, Product? product, bool isOffline
});




}
/// @nodoc
class __$productStateCopyWithImpl<$Res>
    implements _$productStateCopyWith<$Res> {
  __$productStateCopyWithImpl(this._self, this._then);

  final _productState _self;
  final $Res Function(_productState) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authtype = null,Object? loadingStatus = null,Object? msg = null,Object? products = null,Object? product = freezed,Object? isOffline = null,}) {
  return _then(_productState(
authtype: null == authtype ? _self.authtype : authtype // ignore: cast_nullable_to_non_nullable
as type,loadingStatus: null == loadingStatus ? _self.loadingStatus : loadingStatus // ignore: cast_nullable_to_non_nullable
as LoadingStatus,msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
