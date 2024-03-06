import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';

class DiUtils{
  static final GetIt _getIt = GetIt.instance;

  static Future<void> _unregisterAll() async {
    await _getIt.reset();
  }

  static GetIt get() {
    GetIt.instance.allowReassignment = true;
    return _getIt;
  }

  static void registerDefaultDi() {
    _unregisterAll();
    RegisterDI registerDI = RegisterDI(DiFactoryImpl());
    registerDI.register();
  }

}