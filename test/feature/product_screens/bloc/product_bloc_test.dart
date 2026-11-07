import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_1/core/network_service/local_storage.dart';
import 'package:flutter_application_1/core/network_service/network_service.dart';
import 'package:flutter_application_1/core/repository/dio_client.dart';
import 'package:flutter_application_1/feature/product_screens/model/products_model.dart';
import 'package:flutter_application_1/feature/product_screens/view_model/product_bloc/product_bloc.dart';

import '../../../helpers/product_fixtures.dart';

class MockDioClient extends Mock implements DioClient {}
class MockProductLocalStorage extends Mock implements ProductLocalStorage {}
class MockNetworkService extends Mock implements NetworkService {}

Response<dynamic> apiResponse(dynamic data, String path) => Response<dynamic>(
  requestOptions: RequestOptions(path: path),
  data: data,
  statusCode: 200,
);

void main() {
  late MockDioClient client;
  late MockProductLocalStorage storage;
  late MockNetworkService network;

  setUp(() {
    client = MockDioClient();
    storage = MockProductLocalStorage();
    network = MockNetworkService();
  });

  ProductBloc createBloc() => ProductBloc(
    client,
    localstorage: storage,
    service: network,
  );

  group('ProductBloc product listing', () {
    blocTest<ProductBloc, ProductState>(
      'emits loading then success when the API returns products',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => true);
        when(() => client.get(endpoint: '/products')).thenAnswer(
          (_) async => apiResponse(productsResponse(), '/products'),
        );
        when(() => storage.getProducts()).thenAnswer((_) async => <Product>[]);
        when(() => storage.saveProducts(any())).thenAnswer((_) async {});
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productLoaded()),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.success)
            .having((s) => s.products.length, 'products length', 1)
            .having((s) => s.products.first.id, 'first product id', 1),
      ],
      verify: (_) {
        verify(() => storage.saveProducts(any())).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'loads cached products when the device is offline',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => false);
        when(() => storage.getProducts()).thenAnswer((_) async => [testProduct()]);
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productLoaded()),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.success)
            .having((s) => s.authtype, 'source', type.offline)
            .having((s) => s.products.single.title, 'cached title', 'Test Product 1'),
      ],
      verify: (_) => verifyNever(() => client.get(endpoint: '/products')),
    );

    blocTest<ProductBloc, ProductState>(
      'uses cached products when the API request fails',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => true);
        when(() => client.get(endpoint: '/products')).thenThrow(Exception('API unavailable'));
        when(() => storage.getProducts()).thenAnswer((_) async => [testProduct()]);
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productLoaded()),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.success)
            .having((s) => s.authtype, 'source', type.offline)
            .having((s) => s.products.length, 'products length', 1),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits error when offline and no cached products exist',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => false);
        when(() => storage.getProducts()).thenAnswer((_) async => <Product>[]);
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productLoaded()),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.error)
            .having((s) => s.msg, 'error message', contains('No internet connection')),
      ],
      verify: (_) => verifyNever(() => client.get(endpoint: '/products')),
    );
  });

  group('ProductBloc product details', () {
    blocTest<ProductBloc, ProductState>(
      'fetches product details from the API when online',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => true);
        when(() => client.get(endpoint: '/products/1')).thenAnswer(
          (_) async => apiResponse(productJson(), '/products/1'),
        );
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productDetailsfetched(1)),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.success)
            .having((s) => s.product?.id, 'product id', 1)
            .having((s) => s.product?.title, 'product title', 'Test Product 1'),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'loads product details from cache when offline',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => false);
        when(() => storage.getProducts()).thenAnswer((_) async => [testProduct()]);
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productDetailsfetched(1)),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.success)
            .having((s) => s.authtype, 'source', type.offline)
            .having((s) => s.product?.id, 'product id', 1),
      ],
      verify: (_) => verifyNever(() => client.get(endpoint: '/products/1')),
    );

    blocTest<ProductBloc, ProductState>(
      'emits error when requested product is not present in offline cache',
      setUp: () {
        when(() => network.isConnected()).thenAnswer((_) async => false);
        when(() => storage.getProducts()).thenAnswer((_) async => <Product>[]);
      },
      build: createBloc,
      act: (bloc) => bloc.add(const ProductEvent.productDetailsfetched(999)),
      expect: () => [
        isA<ProductState>().having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.loading),
        isA<ProductState>()
            .having((s) => s.loadingStatus, 'loadingStatus', LoadingStatus.error)
            .having((s) => s.msg, 'error message', contains('not available offline')),
      ],
    );
  });
}
