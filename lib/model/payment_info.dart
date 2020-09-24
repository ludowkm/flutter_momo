import 'package:flutter_momo/utils/string_utils.dart';

class PaymentInfo {
  String merchantCode;
  String merchantName;
  String partnerCode;
  String orderId;
  int amount;
  int fee;
  String description;
  String appScheme;

  bool isTestMode;

  PaymentInfo(
      {this.merchantCode,
      this.merchantName,
      this.orderId,
      this.amount,
      this.partnerCode,
      this.description,
      this.appScheme,
      this.fee = 0,
      this.isTestMode = false})
      : assert(!isBlank(merchantCode) &&
            !isBlank(merchantName) &&
            !isBlank(partnerCode) &&
            !isBlank(orderId) &&
            !isBlank(description) &&
            amount != null &&
            amount > 0 &&
            fee != null &&
            fee >= 0 &&
            isTestMode != null &&
            isTestMode is bool);

  Map<String, dynamic> toJson() => {
        'merchantname': merchantCode,
        'merchantcode': merchantName,
        'orderId': orderId,
        'partnerCode': partnerCode,
        'amount': amount,
        'fee': fee,
        'description': description,
        'appScheme': appScheme,
        'isTestMode': isTestMode,
      };
}
