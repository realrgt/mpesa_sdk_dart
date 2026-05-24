import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';
import 'package:test/test.dart';

import 'fixtures/keys.dart';

void main() {
  late MpesaCredentials credentials;

  setUp(() {
    credentials = const MpesaCredentials(
      apiKey: testApiKey,
      publicKey: testPublicKey,
    );
  });

  group('MpesaClient', () {
    test('c2b sends expected payload, headers and endpoint', () async {
      late http.Request capturedRequest;
      final mockClient = MockClient((request) async {
        capturedRequest = request;
        return http.Response(
          jsonEncode(<String, dynamic>{
            'output_ResponseCode': 'INS-0',
            'output_ResponseDesc': 'Success',
          }),
          201,
          headers: <String, String>{'x-trace-id': 'abc-123'},
        );
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
      );

      final result = await client.c2b(
        PaymentRequest(
          transactionReference: 'T12344C',
          customerMsisdn: '258847522988',
          amount: 10,
          thirdPartyReference: '11114',
          serviceProviderCode: '171717',
        ),
      );

      expect(capturedRequest.method, 'POST');
      expect(capturedRequest.url.host, 'api.sandbox.vm.co.mz');
      expect(capturedRequest.url.port, 18352);
      expect(capturedRequest.url.path, '/ipg/v1x/c2bPayment/singleStage/');
      expect(capturedRequest.headers['content-type'], 'application/json');
      expect(capturedRequest.headers['authorization'], startsWith('Bearer '));

      final sentBody = jsonDecode(capturedRequest.body) as Map<String, dynamic>;
      expect(sentBody['input_Amount'], 10);
      expect(sentBody['input_CustomerMSISDN'], '258847522988');

      expect(result.statusCode, 201);
      expect(result.data.outputResponseCode, 'INS-0');
      expect(result.headers['x-trace-id'], 'abc-123');
    });

    test('queryTransactionStatus sends encoded query parameters', () async {
      late Uri capturedUri;
      final mockClient = MockClient((request) async {
        capturedUri = request.url;
        return http.Response(
          '{"output_ResponseCode":"INS-0","output_ResponseDesc":"Success"}',
          200,
        );
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
      );

      await client.queryTransactionStatus(
        TransactionStatusRequest(
          thirdPartyReference: 'TP-1',
          queryReference: 'Q REF',
          serviceProviderCode: '171717',
        ),
      );

      expect(capturedUri.host, 'api.sandbox.vm.co.mz');
      expect(capturedUri.port, 18353);
      expect(capturedUri.path, '/ipg/v1x/queryTransactionStatus/');
      expect(capturedUri.queryParameters['input_QueryReference'], 'Q REF');
    });

    test('throws auth exception for unauthorized responses', () async {
      final mockClient = MockClient((_) async {
        return http.Response(
          '{"output_ResponseCode":"INS-4","output_ResponseDesc":"Unauthorized"}',
          401,
        );
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
      );

      expect(
        () => client.c2b(
          PaymentRequest(
            transactionReference: 'T1',
            customerMsisdn: '25884',
            amount: 1,
            thirdPartyReference: 'R1',
            serviceProviderCode: '171717',
          ),
        ),
        throwsA(isA<MpesaAuthException>()),
      );
    });

    test('throws api exception for non-2xx responses', () async {
      final mockClient = MockClient((_) async {
        return http.Response(
          '{"output_ResponseCode":"INS-5","output_ResponseDesc":"Server error"}',
          500,
        );
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
      );

      expect(
        () => client.b2c(
          PaymentRequest(
            transactionReference: 'T1',
            customerMsisdn: '25884',
            amount: 1,
            thirdPartyReference: 'R1',
            serviceProviderCode: '171717',
          ),
        ),
        throwsA(isA<MpesaApiException>()),
      );
    });

    test('throws serialization exception when response is invalid json',
        () async {
      final mockClient = MockClient((_) async {
        return http.Response('not-json', 200);
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
      );

      expect(
        () => client.b2b(
          TransferRequest(
            transactionReference: 'T1',
            amount: 2,
            thirdPartyReference: 'R1',
            primaryPartyCode: '171717',
            receiverPartyCode: '181818',
          ),
        ),
        throwsA(isA<MpesaSerializationException>()),
      );
    });

    test('throws network exception on timeout', () async {
      final mockClient = MockClient((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return http.Response(
          '{"output_ResponseCode":"INS-0","output_ResponseDesc":"Success"}',
          200,
        );
      });

      final client = MpesaClient(
        credentials: credentials,
        httpClient: mockClient,
        timeout: const Duration(milliseconds: 1),
      );

      expect(
        () => client.c2b(
          PaymentRequest(
            transactionReference: 'T1',
            customerMsisdn: '25884',
            amount: 1,
            thirdPartyReference: 'R1',
            serviceProviderCode: '171717',
          ),
        ),
        throwsA(isA<MpesaNetworkException>()),
      );
    });
  });
}
