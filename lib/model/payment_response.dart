class PaymentResponse {
  bool isSuccess;
  String message;
  String token;
  String phoneNumber;

  PaymentResponse.fromJson(Map<dynamic, dynamic> json)
      : isSuccess = json['isSuccess'],
        message = json['message'],
        token = json['token'],
        phoneNumber = json['phoneNumber'];

  String toString() =>
      'Success: $isSuccess/Message: $message/Token: $token/Phone Number: $phoneNumber';
}
