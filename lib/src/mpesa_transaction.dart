import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mpesa_sdk_dart/src/payment_request.dart';
import 'package:mpesa_sdk_dart/src/reversal_request.dart';
import 'package:mpesa_sdk_dart/src/transfer_request.dart';

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

  static b2c(String token, PaymentRequest paymentRequest) async {
    http.Response response;
    var url = 'https://api.sandbox.vm.co.mz:18345/ipg/v1x/b2cPayment/';
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

  static reversal(String token, ReversalRequest reversalRequest) async {
    http.Response response;
    var url = 'https://api.sandbox.vm.co.mz:18354/ipg/v1x/reversal/';
    await http
        .put(
      url,
      headers: {
        'content-type': 'application/json',
        'authorization': '$token',
        'origin': '*',
      },
      body: reversalRequestToJson(reversalRequest),
      encoding: utf8,
    )
        .then((res) {
      print('${res.statusCode} :${res.reasonPhrase}');
      print(res.body);
      response = res;
    });
    return response;
  }

  static getTransactionStatus(token, inputThirdPartyReference,
      inputQueryReference, inputServiceProviderCode) async {
    http.Response response;
    var url =
        'https://api.sandbox.vm.co.mz:18353/ipg/v1x/queryTransactionStatus/?input_ThirdPartyReference=$inputThirdPartyReference&input_QueryReference=$inputQueryReference&input_ServiceProviderCode=$inputServiceProviderCode';
    await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        'authorization': '$token',
        'origin': '*',
      },
    ).then((res) {
      print('${res.statusCode} :${res.reasonPhrase}');
      print(res.body);
      response = res;
    });
    return response;
  }

  static b2b(String token, TransferRequest transferRequest) async {
    http.Response response;
    var url = 'https://api.sandbox.vm.co.mz:18349/ipg/v1x/b2bPayment/';
    await http
        .post(
      url,
      headers: {
        'content-type': 'application/json',
        'authorization': '$token',
        'origin': '*',
      },
      body: transferRequestToJson(transferRequest),
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
