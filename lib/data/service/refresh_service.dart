import 'dart:async';
import 'dart:collection';

class RefreshService {
  final refreshTimeInSeconds = 15;
  final HashMap<String, Function> _listeners = HashMap();
  Timer? _refreshTimer = null;

  RefreshService() {
    _refreshTimer =
        Timer.periodic(Duration(seconds: refreshTimeInSeconds), (timer) {
      // ignore: unused_local_variable
      for (var callback in _listeners.values) {
        // callback.call();
      }
    });
  }

  void registerForRefresh(String routeName, Function callback) {
    _listeners[routeName] = callback;
  }

  void unRegisterForRefresh(String routeName) {
    _listeners.remove(routeName);
  }
}
