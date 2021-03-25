import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mpesa_sdk_dart/src/models/payment_request.dart';
import 'package:mpesa_sdk_dart/src/models/reversal_request.dart';
import 'package:mpesa_sdk_dart/src/models/transfer_request.dart';

class MpesaTransaction {
  /// Initiates a C2B transaction on the M-Pesa API.
  ///
  /// Given a [token] and an instance of [PaymentRequest],
  /// returns an http [Response]
  ///
  static c2b(String? token, PaymentRequest paymentRequest) async {
    http.Response? response;
    var url =
        'https://api.sandbox.vm.co.mz:18352/ipg/v1x/c2bPayment/singleStage/';
    await http
        .post(
      Uri.parse(url),
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

  /// Initiates a B2C transaction on the M-Pesa API.
  ///
  /// Given a [token] and an instance of [PaymentRequest],
  /// returns an http [Response]
  ///
  static b2c(String token, PaymentRequest paymentRequest) async {
    http.Response? response;
    var url = 'https://api.sandbox.vm.co.mz:18345/ipg/v1x/b2cPayment/';
    await http
        .post(
      Uri.parse(url),
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

  /// Initiates a Reversal Transaction on the M-Pesa API.
  ///
  /// Given a [token] and an istance of [ReversalRequest],
  /// returns an http [Response]
  ///
  static reversal(String token, ReversalRequest reversalRequest) async {
    http.Response? response;
    var url = 'https://api.sandbox.vm.co.mz:18354/ipg/v1x/reversal/';
    await http
        .put(
      Uri.parse(url),
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

  /// Initiates a transaction Query on the M-Pesa API.
  /// and returns an http [Response]
  ///
  static getTransactionStatus(token, inputThirdPartyReference,
      inputQueryReference, inputServiceProviderCode) async {
    http.Response? response;
    var url =
        'https://api.sandbox.vm.co.mz:18353/ipg/v1x/queryTransactionStatus/?input_ThirdPartyReference=$inputThirdPartyReference&input_QueryReference=$inputQueryReference&input_ServiceProviderCode=$inputServiceProviderCode';
    await http.get(
      Uri.parse(url),
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

  /// Initiates a B2B transaction on the M-Pesa API.
  ///
  /// Given a [token] and an instance of [PaymentRequest],
  /// returns an http [Response]
  ///
  static b2b(String token, TransferRequest transferRequest) async {
    http.Response? response;
    var url = 'https://api.sandbox.vm.co.mz:18349/ipg/v1x/b2bPayment/';
    await http
        .post(
      Uri.parse(url),
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
