import 'dart:async';
import '../login_and_registration/common/result.dart';

abstract class HttpHelperAuth {
  Future<Result> get(String url);
  Future<Result> post(String url, dynamic body);
  Future<Result> put(String url, dynamic body);
  Future<Result> delete(String url, dynamic body);

}
