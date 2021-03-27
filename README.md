# mpesa_sdk_dart

[![Pub Version](https://img.shields.io/pub/v/mpesa_sdk_dart?color=blue)](https://pub.dev/packages/mpesa_sdk_dart)
![GitHub](https://img.shields.io/github/license/realrgt/mpesa_sdk_dart)
![GitHub repo size](https://img.shields.io/github/repo-size/realrgt/mpesa_sdk_dart?color=red)

Dart package for M-Pesa API (Mozambique)

Ready Methods/APIs

- [x] C2B
- [x] B2B
- [x] B2C
- [x] TRANSACTION STATUS
- [x] REVERSAL

## Requisites

We highly recommend reading Mpesa API [docs](https://developer.mpesa.vm.co.mz/) first!

You Will need a few things from there before development.

1. Api Key
2. Public Key

- Login or Register as a M-Pesa developer [here](https://developer.mpesa.vm.co.mz/accounts/login/?next=/accounts/signup/) if you haven't.
- You will be issued with an API Key and a Public Key. You will use these to generate your access token.

## Usage

Add dependency in pubspec.yaml

```yaml
dependencies:
  mpesa_sdk_dart: <latest_version>
```

Import in your Flutter app or plain dart app.

```dart
import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';
```

### Generate a token

```dart
String token = MpesaConfig.getBearerToken(
    'API_KEY_HERE',
    'PUBLIC_KEY_HERE',
  );
```

### C2B Api Call

#### Initialize your payload

```dart
PaymentRequest payload = PaymentRequest(
    inputTransactionReference: 'inputTransactionReference',
    inputCustomerMsisdn: '25884xxxxxxx',
    inputAmount: inputAmount,
    inputThirdPartyReference: 'inputThirdPartyReference',
    inputServiceProviderCode: 'inputServiceProviderCode',
  );
```

#### Perform the api call

```dart
MpesaTransaction.c2b(apiHost, token, payload);
```

### B2C Api Call

#### Initialize your payload

```dart
PaymentRequest payload = PaymentRequest(
    inputTransactionReference: 'inputTransactionReference',
    inputCustomerMsisdn: '25884xxxxxxx',
    inputAmount: inputAmount,
    inputThirdPartyReference: 'inputThirdPartyReference',
    inputServiceProviderCode: 'inputServiceProviderCode',
  );
```

#### Perform the api call

```dart
MpesaTransaction.b2c(apiHost, token, payload);
```

### Reversal Api Call

#### Initialize your payload

```dart
ReversalRequest payload = ReversalRequest(
    inputTransactionID: 'input_TransactionID',
    inputSecurityCredential: 'input_SecurityCredential',
    inputInitiatorIdentifier: 'input_InitiatorIdentifier',
    inputThirdPartyReference: 'input_ThirdPartyReference',
    inputServiceProviderCode: 'input_ServiceProviderCode',
    inputReversalAmount: montant, // Optional
  );
```

#### Perform the api call

```dart
MpesaTransaction.reversal(apiHost, token, payload);
```

### B2B Api Call

#### Initialize your payload

```dart
TransferRequest payload = TransferRequest(
    inputTransactionReference: 'input_TransactionReference',
    inputAmount: inputAmount,
    inputThirdPartyReference: 'input_ThirdPartyReference',
    inputPrimaryPartyCode: 'input_PrimaryPartyCode',
    inputReceiverPartyCode: 'input_ReceiverPartyCode',
  );
```

#### Perform the api call

```dart
MpesaTransaction.b2b(apiHost, token, payload);
```

### Query Transaction Status Api Call

#### Perform the api call

```dart
MpesaTransaction.getTransactionStatus(
    apiHost,
    token,
    'input_ThirdPartyReference',
    'input_QueryReference',
    'input_ServiceProviderCode',
  );
```

## Handle Response

All transaction methods returned an http response. So what you have to do is assign your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async task.

```dart
Response response = await MpesaTransaction.c2b(apiHost, token, payload);
print(response.body);

if(response.statusCode == 201) {  // if is resource created!
  // Do something!
}
```

## Copyright and license

MIT License

Copyright (c) 2020-2021 Ergito Vilanculos

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
