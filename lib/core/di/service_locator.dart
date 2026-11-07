import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/network_service/local_storage.dart';
import 'package:flutter_application_1/core/network_service/network_service.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/core/repository/dio_client.dart';
import 'package:flutter_application_1/feature/product_screens/view_model/product_bloc/product_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(prefs);
  sl.registerFactory<ProductBloc>(
    () => ProductBloc(sl<DioClient>(), localstorage: sl(), service: sl()),
  );

  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ProductLocalStorage>(() => ProductLocalStorage());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkService>(() => NetworkService(connectivity: sl()));
}
