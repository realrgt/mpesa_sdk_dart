import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config/mpesa_credentials.dart';
import 'config/mpesa_environment.dart';
import 'crypto/rsa_encryptor.dart';
import 'exceptions/mpesa_exception.dart';
import 'models/mpesa_api_response.dart';
import 'models/mpesa_result.dart';
import 'models/payment_request.dart';
import 'models/reversal_request.dart';
import 'models/transaction_status_request.dart';
import 'models/transfer_request.dart';

enum _HttpMethod { get, post, put }

class MpesaClient {
  MpesaClient({
    required MpesaCredentials credentials,
    MpesaEnvironment environment = MpesaEnvironment.sandbox,
    String? apiHost,
    http.Client? httpClient,
    Duration timeout = const Duration(seconds: 20),
  })  : _credentials = credentials,
        _environment = environment,
        _apiHost = apiHost ?? environment.defaultHost,
        _httpClient = httpClient ?? http.Client(),
        _ownsHttpClient = httpClient == null,
        _timeout = timeout,
        _encryptor = const RsaEncryptor();

  final MpesaCredentials _credentials;
  final MpesaEnvironment _environment;
  final String _apiHost;
  final http.Client _httpClient;
  final bool _ownsHttpClient;
  final Duration _timeout;
  final RsaEncryptor _encryptor;

  static const int _c2bPort = 18352;
  static const int _b2cPort = 18345;
  static const int _b2bPort = 18349;
  static const int _reversalPort = 18354;
  static const int _statusPort = 18353;

  String get apiHost => _apiHost;
  MpesaEnvironment get environment => _environment;

  Future<MpesaResult<MpesaApiResponse>> c2b(PaymentRequest request) {
    return _send(
      method: _HttpMethod.post,
      path: '/ipg/v1x/c2bPayment/singleStage/',
      port: _c2bPort,
      body: request.toJson(),
    );
  }

  Future<MpesaResult<MpesaApiResponse>> b2c(PaymentRequest request) {
    return _send(
      method: _HttpMethod.post,
      path: '/ipg/v1x/b2cPayment/',
      port: _b2cPort,
      body: request.toJson(),
    );
  }

  Future<MpesaResult<MpesaApiResponse>> b2b(TransferRequest request) {
    return _send(
      method: _HttpMethod.post,
      path: '/ipg/v1x/b2bPayment/',
      port: _b2bPort,
      body: request.toJson(),
    );
  }

  Future<MpesaResult<MpesaApiResponse>> reversal(ReversalRequest request) {
    return _send(
      method: _HttpMethod.put,
      path: '/ipg/v1x/reversal/',
      port: _reversalPort,
      body: request.toJson(),
    );
  }

  Future<MpesaResult<MpesaApiResponse>> queryTransactionStatus(
    TransactionStatusRequest request,
  ) {
    return _send(
      method: _HttpMethod.get,
      path: '/ipg/v1x/queryTransactionStatus/',
      port: _statusPort,
      queryParameters: request.toQueryParameters(),
    );
  }

  void close() {
    if (_ownsHttpClient) {
      _httpClient.close();
    }
  }

  Future<MpesaResult<MpesaApiResponse>> _send({
    required _HttpMethod method,
    required String path,
    required int port,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri(
      scheme: 'https',
      host: _apiHost,
      port: port,
      path: path,
      queryParameters: queryParameters,
    );

    final headers = _buildHeaders();

    final http.Response response;
    try {
      switch (method) {
        case _HttpMethod.get:
          response =
              await _httpClient.get(uri, headers: headers).timeout(_timeout);
          break;
        case _HttpMethod.post:
          response = await _httpClient
              .post(
                uri,
                headers: headers,
                body: jsonEncode(body),
                encoding: utf8,
              )
              .timeout(_timeout);
          break;
        case _HttpMethod.put:
          response = await _httpClient
              .put(
                uri,
                headers: headers,
                body: jsonEncode(body),
                encoding: utf8,
              )
              .timeout(_timeout);
          break;
      }
    } on TimeoutException catch (error) {
      throw MpesaNetworkException('Request timeout reached: $_timeout',
          cause: error);
    } on http.ClientException catch (error) {
      throw MpesaNetworkException('HTTP client error: ${error.message}',
          cause: error);
    } catch (error) {
      throw MpesaNetworkException('Unexpected network error', cause: error);
    }

    final payload = _decodeResponse(response.body);
    final apiResponse = MpesaApiResponse.fromJson(payload);
    final result = MpesaResult<MpesaApiResponse>(
      statusCode: response.statusCode,
      reasonPhrase: response.reasonPhrase ?? '',
      data: apiResponse,
      headers: response.headers,
      rawBody: response.body,
    );

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw MpesaAuthException(
        apiResponse.outputResponseDesc,
        statusCode: response.statusCode,
      );
    }

    if (!result.isHttpSuccess) {
      throw MpesaApiException(
        statusCode: response.statusCode,
        response: apiResponse,
        message: apiResponse.outputResponseDesc,
        rawBody: response.body,
      );
    }

    return result;
  }

  Map<String, String> _buildHeaders() {
    final bearerToken = _encryptor.encryptToBase64(
      plaintext: _credentials.apiKey,
      publicKeyPem: _credentials.publicKey,
    );

    return <String, String>{
      'content-type': 'application/json',
      'authorization': 'Bearer $bearerToken',
      'origin': '*',
    };
  }

  Map<String, dynamic> _decodeResponse(String responseBody) {
    if (responseBody.trim().isEmpty) {
      return const <String, dynamic>{};
    }

    final dynamic decoded;
    try {
      decoded = jsonDecode(responseBody);
    } catch (_) {
      throw MpesaSerializationException(
        'Failed to decode API response body as JSON.',
        rawBody: responseBody,
      );
    }

    if (decoded is! Map<String, dynamic>) {
      throw MpesaSerializationException(
        'Expected JSON object response from M-Pesa API.',
        rawBody: responseBody,
      );
    }

    return decoded;
  }
}
