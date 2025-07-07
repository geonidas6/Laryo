import 'package:easy_localization/easy_localization.dart';
import 'dart:ui';

class TestAssetLoader extends AssetLoader {
  final Map<String, dynamic> data;
  const TestAssetLoader(this.data);

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return data;
  }
}
