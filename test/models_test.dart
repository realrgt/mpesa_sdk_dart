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
  });
}
