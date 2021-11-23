import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/payment_request.dart';
import '../models/reversal_request.dart';
import '../models/transfer_request.dart';

class MpesaTransaction {
  /// Initiates a C2B transaction on the M-Pesa API.
  ///
  /// Given a [token] and an instance of [PaymentRequest],
  /// returns an http [Response]
  ///
  static c2b(
    String token,
    String apiHost,
    PaymentRequest paymentRequest,
  ) async {
    http.Response? response;
    var url = 'https://$apiHost:18352/ipg/v1x/c2bPayment/singleStage/';
    await http
        .post(
      Uri.parse(url),
      headers: getHeaders(token),
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
  static b2c(
    String token,
    String apiHost,
    PaymentRequest paymentRequest,
  ) async {
    http.Response? response;
    var url = 'https://$apiHost:18345/ipg/v1x/b2cPayment/';
    await http
        .post(
      Uri.parse(url),
      headers: getHeaders(token),
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
  static reversal(
    String token,
    String apiHost,
    ReversalRequest reversalRequest,
  ) async {
    http.Response? response;
    var url = 'https://$apiHost:18354/ipg/v1x/reversal/';
    await http
        .put(
      Uri.parse(url),
      headers: getHeaders(token),
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
  static getTransactionStatus(
    token,
    apiHost,
    inputThirdPartyReference,
    inputQueryReference,
    inputServiceProviderCode,
  ) async {
    http.Response? response;
    var url =
        'https://$apiHost:18353/ipg/v1x/queryTransactionStatus/?input_ThirdPartyReference=$inputThirdPartyReference&input_QueryReference=$inputQueryReference&input_ServiceProviderCode=$inputServiceProviderCode';
    await http
        .get(
      Uri.parse(url),
      headers: getHeaders(token),
    )
        .then((res) {
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
  static b2b(
    String token,
    String apiHost,
    TransferRequest transferRequest,
  ) async {
    http.Response? response;
    var url = 'https://$apiHost:18349/ipg/v1x/b2bPayment/';
    await http
        .post(
      Uri.parse(url),
      headers: getHeaders(token),
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

  static Map<String, String> getHeaders(String token) {
    return {
      'content-type': 'application/json',
      'authorization': '$token',
      'origin': '*',
    };
  }
}
