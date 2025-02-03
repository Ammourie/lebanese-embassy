import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkInfo {
  ValueNotifier<ConnectivityResult> connectivityNotifier =
      ValueNotifier(ConnectivityResult.none);
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  NetworkInfo() {
    initialize();
  }

  void initialize() {
    // Initial check
    Connectivity().checkConnectivity().then((result) {
      connectivityNotifier.value = result;
    });

    // Listen for changes
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (connectivityNotifier.value != result) {
        // if (connectivityNotifier.value != ConnectivityResult.none)
        // sl<TaskBloc>().add(SyncTaskEvent());
      }
      connectivityNotifier.value = result;
    });
  }

  void dispose() {
    _connectivitySubscription?.cancel();
  }
}
