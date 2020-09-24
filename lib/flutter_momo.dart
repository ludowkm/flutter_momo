import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_momo/model/payment_info.dart';
import 'package:flutter_momo/utils/string_utils.dart';

import 'model/payment_response.dart';

export 'model/payment_info.dart';
export 'model/payment_response.dart';

class FlutterMomo {
  static const MethodChannel _channel = const MethodChannel('flutter_momo');

  static Future<PaymentResponse> requestPayment(PaymentInfo paymentInfo) async {
    if (Platform.isIOS && isBlank(paymentInfo.appScheme)) {
      throw PlatformException(
          code: 'miss_app_scheme', message: 'App Scheme is required for iOS');
    }
    final response =
        await _channel.invokeMethod('requestPayment', paymentInfo.toJson());
    return PaymentResponse.fromJson(response);
  }

  /*
  This method support dynamic payment info params that follow definition of MoMo
  Make sure you use it correctly or use the #requestPayment to guarantee the accuracy
   */
  static Future<PaymentResponse> requestDynamicPayment(
      Map<String, dynamic> paymentInfo) async {
    final response = await _channel.invokeMethod('requestPayment', paymentInfo);
    return PaymentResponse.fromJson(response);
  }
}
