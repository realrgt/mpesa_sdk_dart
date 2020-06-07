// To parse this JSON data, do
//
//     final paymentRequest = paymentRequestFromJson(jsonString);

import 'dart:convert';

PaymentRequest paymentRequestFromJson(String str) => PaymentRequest.fromJson(json.decode(str));

String paymentRequestToJson(PaymentRequest data) => json.encode(data.toJson());

class PaymentRequest {

  PaymentRequest({
    this.inputTransactionReference,
    this.inputCustomerMsisdn,
    this.inputAmount,
    this.inputThirdPartyReference,
    this.inputServiceProviderCode,
  });

  String inputTransactionReference;
  String inputCustomerMsisdn;
  double inputAmount;
  String inputThirdPartyReference;
  String inputServiceProviderCode;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => PaymentRequest(
    inputTransactionReference: json["input_TransactionReference"],
    inputCustomerMsisdn: json["input_CustomerMSISDN"],
    inputAmount: json["input_Amount"],
    inputThirdPartyReference: json["input_ThirdPartyReference"],
    inputServiceProviderCode: json["input_ServiceProviderCode"],
  );

  Map<String, dynamic> toJson() => {
    "input_TransactionReference": inputTransactionReference,
    "input_CustomerMSISDN": inputCustomerMsisdn,
    "input_Amount": inputAmount.toString(),
    "input_ThirdPartyReference": inputThirdPartyReference,
    "input_ServiceProviderCode": inputServiceProviderCode,
  };
  
}
