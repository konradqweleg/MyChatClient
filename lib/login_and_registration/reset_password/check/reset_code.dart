import 'package:flutter/cupertino.dart';

abstract class ResetCode{
  void sendCode(BuildContext context,String email);
}