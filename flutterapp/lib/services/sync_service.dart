import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'api_service.dart';
import 'secure_auth_service.dart';

class SyncService {
  static const _boxName = 'queued_actions';
  static const _key = 'actions';

  final ApiService _api;
  final SecureAuthService _auth;
  late Box _box;

  SyncService({ApiService? api, SecureAuthService? auth})
      : _api = api ?? ApiService(),
        _auth = auth ?? SecureAuthService();

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        flushQueue();
      }
    });
  }

  Future<void> queueAction(Map<String, dynamic> action) async {
    final List<dynamic> list = _box.get(_key, defaultValue: <dynamic>[]) as List<dynamic>;
    list.add(action);
    await _box.put(_key, list);
  }

  Future<void> flushQueue() async {
    final List<dynamic> list = _box.get(_key, defaultValue: <dynamic>[]) as List<dynamic>;
    if (list.isEmpty) return;
    final token = await _auth.getToken();
    if (token == null) return;
    final success = await _api.syncRecords(token, List<Map<String, dynamic>>.from(list));
    if (success) {
      await _box.put(_key, <dynamic>[]);
    }
  }
}
