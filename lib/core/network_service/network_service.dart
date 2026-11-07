import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity connectivity;
  NetworkService({required this.connectivity});
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Stream<bool> get connectivityStream =>
      connectivity.onConnectivityChanged.map((result) => result != ConnectivityResult.none);
}
