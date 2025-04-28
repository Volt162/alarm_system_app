import 'package:liqpay/liqpay.dart';

/// Base LiqPay error response
class LiqPayErrorResponse extends LiqPayResponse {
  final String? errorCode;
  final String? errorDescription;
  LiqPayErrorResponse(String result, String status, String version,
      LiqPayAction action, this.errorCode, this.errorDescription)
      : super(result, status, version, action);

  factory LiqPayErrorResponse.fromJson(Map<String, dynamic> json) =>
      LiqPayErrorResponse(
        json['result'] as String,
        json['status'] as String,
        json['version'] as String,
        LiqPayAction.fromValue(json['action']),
        json['err_code'] as String?,
        json['err_description'] as String?,
      );
}
