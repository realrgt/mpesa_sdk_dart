import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';
import 'package:test/test.dart';

void main() {
  group('PaymentRequest', () {
    test('serializes to expected M-Pesa field names', () {
      final request = PaymentRequest(
        transactionReference: 'T12344C',
        customerMsisdn: '258847522988',
        amount: 10,
        thirdPartyReference: '11114',
        serviceProviderCode: '171717',
      );

      expect(request.toJson(), <String, dynamic>{
        'input_TransactionReference': 'T12344C',
        'input_CustomerMSISDN': '258847522988',
        'input_Amount': 10,
        'input_ThirdPartyReference': '11114',
        'input_ServiceProviderCode': '171717',
      });
    });

    test('throws when amount is invalid', () {
      expect(
        () => PaymentRequest(
          transactionReference: 'A',
          customerMsisdn: '25884',
          amount: 0,
          thirdPartyReference: 'B',
          serviceProviderCode: 'C',
        ),
        throwsArgumentError,
      );
    });

    test('builds instance from json payload', () {
      final request = PaymentRequest.fromJson(<String, dynamic>{
        'input_TransactionReference': 'T900',
        'input_CustomerMSISDN': '258840000000',
        'input_Amount': 50,
        'input_ThirdPartyReference': 'TP-900',
        'input_ServiceProviderCode': '171717',
      });

      expect(request.transactionReference, 'T900');
      expect(request.customerMsisdn, '258840000000');
      expect(request.amount, 50);
      expect(request.thirdPartyReference, 'TP-900');
      expect(request.serviceProviderCode, '171717');
    });

    test('throws when required fields are empty', () {
      expect(
        () => PaymentRequest(
          transactionReference: ' ',
          customerMsisdn: '25884',
          amount: 1,
          thirdPartyReference: 'B',
          serviceProviderCode: 'C',
        ),
        throwsArgumentError,
      );
      expect(
        () => PaymentRequest(
          transactionReference: 'A',
          customerMsisdn: ' ',
          amount: 1,
          thirdPartyReference: 'B',
          serviceProviderCode: 'C',
        ),
        throwsArgumentError,
      );
      expect(
        () => PaymentRequest(
          transactionReference: 'A',
          customerMsisdn: '25884',
          amount: 1,
          thirdPartyReference: ' ',
          serviceProviderCode: 'C',
        ),
        throwsArgumentError,
      );
      expect(
        () => PaymentRequest(
          transactionReference: 'A',
          customerMsisdn: '25884',
          amount: 1,
          thirdPartyReference: 'B',
          serviceProviderCode: ' ',
        ),
        throwsArgumentError,
      );
    });
  });

  group('TransferRequest', () {
    test('throws when reference is empty', () {
      expect(
        () => TransferRequest(
          transactionReference: ' ',
          amount: 10,
          thirdPartyReference: 'third',
          primaryPartyCode: '171717',
          receiverPartyCode: '191919',
        ),
        throwsArgumentError,
      );
    });

    test('builds instance from json payload', () {
      final request = TransferRequest.fromJson(<String, dynamic>{
        'input_TransactionReference': 'TX-1',
        'input_Amount': 15,
        'input_ThirdPartyReference': 'TP-1',
        'input_PrimaryPartyCode': '171717',
        'input_ReceiverPartyCode': '191919',
      });

      expect(request.transactionReference, 'TX-1');
      expect(request.amount, 15);
      expect(request.thirdPartyReference, 'TP-1');
      expect(request.primaryPartyCode, '171717');
      expect(request.receiverPartyCode, '191919');
    });

    test('throws when required fields are empty or amount is invalid', () {
      expect(
        () => TransferRequest(
          transactionReference: 'TX',
          amount: 0,
          thirdPartyReference: 'TP',
          primaryPartyCode: '171717',
          receiverPartyCode: '191919',
        ),
        throwsArgumentError,
      );
      expect(
        () => TransferRequest(
          transactionReference: 'TX',
          amount: 1,
          thirdPartyReference: ' ',
          primaryPartyCode: '171717',
          receiverPartyCode: '191919',
        ),
        throwsArgumentError,
      );
      expect(
        () => TransferRequest(
          transactionReference: 'TX',
          amount: 1,
          thirdPartyReference: 'TP',
          primaryPartyCode: ' ',
          receiverPartyCode: '191919',
        ),
        throwsArgumentError,
      );
      expect(
        () => TransferRequest(
          transactionReference: 'TX',
          amount: 1,
          thirdPartyReference: 'TP',
          primaryPartyCode: '171717',
          receiverPartyCode: ' ',
        ),
        throwsArgumentError,
      );
    });
  });

  group('ReversalRequest', () {
    test('serializes with optional reversal amount', () {
      final request = ReversalRequest(
        transactionId: 'TRX-1',
        securityCredential: 'SEC',
        initiatorIdentifier: 'INIT',
        thirdPartyReference: 'TP-1',
        serviceProviderCode: '171717',
        reversalAmount: 20,
      );

      expect(request.toJson(), <String, dynamic>{
        'input_TransactionID': 'TRX-1',
        'input_SecurityCredential': 'SEC',
        'input_InitiatorIdentifier': 'INIT',
        'input_ThirdPartyReference': 'TP-1',
        'input_ServiceProviderCode': '171717',
        'input_ReversalAmount': 20,
      });
    });

    test('serializes without optional reversal amount', () {
      final request = ReversalRequest(
        transactionId: 'TRX-2',
        securityCredential: 'SEC',
        initiatorIdentifier: 'INIT',
        thirdPartyReference: 'TP-2',
        serviceProviderCode: '171717',
      );

      final payload = request.toJson();
      expect(payload['input_TransactionID'], 'TRX-2');
      expect(payload.containsKey('input_ReversalAmount'), isFalse);
    });

    test('builds instance from json payload', () {
      final request = ReversalRequest.fromJson(<String, dynamic>{
        'input_TransactionID': 'TRX-9',
        'input_SecurityCredential': 'SEC-9',
        'input_InitiatorIdentifier': 'INIT-9',
        'input_ThirdPartyReference': 'TP-9',
        'input_ServiceProviderCode': '171717',
        'input_ReversalAmount': 30,
      });

      expect(request.transactionId, 'TRX-9');
      expect(request.securityCredential, 'SEC-9');
      expect(request.initiatorIdentifier, 'INIT-9');
      expect(request.thirdPartyReference, 'TP-9');
      expect(request.serviceProviderCode, '171717');
      expect(request.reversalAmount, 30);
    });

    test('throws on invalid values', () {
      expect(
        () => ReversalRequest(
          transactionId: ' ',
          securityCredential: 'SEC',
          initiatorIdentifier: 'INIT',
          thirdPartyReference: 'TP',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => ReversalRequest(
          transactionId: 'TRX',
          securityCredential: ' ',
          initiatorIdentifier: 'INIT',
          thirdPartyReference: 'TP',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => ReversalRequest(
          transactionId: 'TRX',
          securityCredential: 'SEC',
          initiatorIdentifier: ' ',
          thirdPartyReference: 'TP',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => ReversalRequest(
          transactionId: 'TRX',
          securityCredential: 'SEC',
          initiatorIdentifier: 'INIT',
          thirdPartyReference: ' ',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => ReversalRequest(
          transactionId: 'TRX',
          securityCredential: 'SEC',
          initiatorIdentifier: 'INIT',
          thirdPartyReference: 'TP',
          serviceProviderCode: ' ',
        ),
        throwsArgumentError,
      );
      expect(
        () => ReversalRequest(
          transactionId: 'TRX',
          securityCredential: 'SEC',
          initiatorIdentifier: 'INIT',
          thirdPartyReference: 'TP',
          serviceProviderCode: '171717',
          reversalAmount: 0,
        ),
        throwsArgumentError,
      );
    });
  });

  group('TransactionStatusRequest', () {
    test('maps query params correctly', () {
      final request = TransactionStatusRequest(
        thirdPartyReference: '11114',
        queryReference: 'q-01',
        serviceProviderCode: '171717',
      );

      expect(request.toQueryParameters(), <String, String>{
        'input_ThirdPartyReference': '11114',
        'input_QueryReference': 'q-01',
        'input_ServiceProviderCode': '171717',
      });
    });

    test('throws when required fields are empty', () {
      expect(
        () => TransactionStatusRequest(
          thirdPartyReference: ' ',
          queryReference: 'q-01',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => TransactionStatusRequest(
          thirdPartyReference: '11114',
          queryReference: ' ',
          serviceProviderCode: '171717',
        ),
        throwsArgumentError,
      );
      expect(
        () => TransactionStatusRequest(
          thirdPartyReference: '11114',
          queryReference: 'q-01',
          serviceProviderCode: ' ',
        ),
        throwsArgumentError,
      );
    });
  });

  group('MpesaException hierarchy', () {
    test('renders readable exception strings', () {
      final auth = MpesaAuthException('Unauthorized', statusCode: 401);
      final network = MpesaNetworkException('Timeout', cause: 'socket');
      final serialization =
          MpesaSerializationException('Bad json', rawBody: '[]');
      final response = MpesaApiResponse(
        outputResponseCode: 'INS-5',
        outputResponseDesc: 'Server error',
      );
      final api = MpesaApiException(
        statusCode: 500,
        response: response,
        message: 'Server error',
        rawBody: '{"x":1}',
      );

      expect(auth.toString(), contains('MpesaAuthException'));
      expect(network.toString(), contains('MpesaNetworkException'));
      expect(serialization.toString(), contains('MpesaSerializationException'));
      expect(api.toString(), contains('MpesaApiException'));
      expect(const MpesaException('x').toString(), 'MpesaException: x');
    });
  });
}
