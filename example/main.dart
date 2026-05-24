import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';

import 'mpesa_keys.dart';

Future<void> main() async {
  final client = MpesaClient(
    credentials: const MpesaCredentials(
      apiKey: apiKeyMpesa,
      publicKey: publicKeyMpesa,
    ),
    environment: MpesaEnvironment.sandbox,
  );

  final payload = PaymentRequest(
    transactionReference: 'T12344C',
    customerMsisdn: '258847522988',
    amount: 8.0,
    thirdPartyReference: '11114',
    serviceProviderCode: '171717',
  );

  final response = await client.c2b(payload);
  if (!response.data.isSuccessCode) {
    throw StateError('Transaction failed: ${response.data.outputResponseDesc}');
  }

  client.close();
}
