import 'package:get_it/get_it.dart';

class DiUtils{
  static final GetIt _getIt = GetIt.instance;

  static Future<void> unregisterAll() async {
    await _getIt.reset();
  }

}