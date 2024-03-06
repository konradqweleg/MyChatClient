import 'package:my_chat_client/http/http_helper_auth.dart';
import 'package:my_chat_client/http/request_status/auth_request_status.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';

class MockAuthRequestReturnRedirectToLoginPage extends HttpHelperAuth{


  @override
  Future<Result> get(String url) async{
    return Result.error(AuthRequestStatus.redirectToLoginPage);
  }

  @override
  Future<Result> delete(String url, body) async{
    return Result.error(AuthRequestStatus.redirectToLoginPage);
  }

  @override
  Future<Result> post(String url, body) async{
    return Result.error(AuthRequestStatus.redirectToLoginPage);
  }

  @override
  Future<Result> put(String url, body) async{
    return Result.error(AuthRequestStatus.redirectToLoginPage);
  }

}

