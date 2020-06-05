import 'package:http/http.dart';
import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';

main() async {

  String token = MpesaConfig.getBearerToken(
    'API_KEY_HERE',
    'PUBLIC_KEY_HERE',
  );

  PaymentRequest payload = PaymentRequest(
    inputTransactionReference: 'T12344C',
    inputCustomerMsisdn: '25884xxxxxxx',
    inputAmount: 10,
    inputThirdPartyReference: '11114',
    inputServiceProviderCode: '171717',
  );

  Response response = await MpesaTransaction.c2b(token, payload);
  print(response.body);

}
