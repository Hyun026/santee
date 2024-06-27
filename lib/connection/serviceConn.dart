import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivitySubscription();
  }

  Future<void> _initConnectivitySubscription() async {
    try {
      
      _connectivity.onConnectivityChanged.listen((result) {
        _updateConnectionStatus(result[0]);
      });
      
    } catch (e) {
      print('Error initializing connectivity subscription: $e');
    }
  }

  // Update the connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      print("No internet connection");
    }
  }

  // Check the internet connection (true if connected, false if not)
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
