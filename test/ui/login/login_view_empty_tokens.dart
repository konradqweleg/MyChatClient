import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/di/register_di.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import '../../ui/confirm_register_code/confirm_code_register_test.dart';
import '../mock/di/auth_request/mock_make_auth_requests/mock_di_auth_request_return_always_no_internet_connection.dart';
import '../mock/di/di_utils.dart';


void main() {
  group('Login view empty saved tokens', () {


      tearDown(() async => await DiUtils.unregisterAll()
      );

      testWidgets(
        'The application should remain on the login view when request return redirect to login page.',
            (WidgetTester tester) async {
          //given

          RegisterDI registerDI = RegisterDI(MockDiFactoryRedirectToLoginPage());
          registerDI.register();

          //when
          await Utils.showView(tester, Login());

          //then
          expect(find.byType(Login), findsOneWidget);

        });



  });
}