import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mpesa_sdk_dart/src/payment_request.dart';

class MpesaTransaction {
  static c2b(String token, PaymentRequest paymentRequest) async {
    http.Response response;
    var url =
        'https://api.sandbox.vm.co.mz:18352/ipg/v1x/c2bPayment/singleStage/';
    await http
        .post(
      url,
      headers: {
        'content-type': 'application/json',
        'authorization': '$token',
        'origin': '*',
      },
      body: paymentRequestToJson(paymentRequest),
      encoding: utf8,
    )
        .then((res) {
      print('${res.statusCode} :${res.reasonPhrase}');
      print(res.body);
      response = res;
    });
    return response;
  }
}
