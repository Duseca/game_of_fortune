import 'dart:async' show Future, StreamController;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../enums/network_status.dart';

class NetworkConnectivity {
  //singleton instance
  static NetworkConnectivity get instance => NetworkConnectivity();

  StreamController<NetworkStatus> networkStatusStream =
      StreamController<NetworkStatus>();

  //method to check if the device is connected to network
  Future<NetworkStatus> getNetworkStatus() async {
    //initializing ConnectivityResult
    ConnectivityResult _result = await Connectivity().checkConnectivity();

    //checking if the device is connected to cellular or wifi network
    NetworkStatus _networkStatus = _result == ConnectivityResult.mobile ||
            _result == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;

    return _networkStatus;
  }
}
