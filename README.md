# mpesa_sdk_dart

Dart package for M-Pesa API (Mozambique)

Ready Methods/APIs

- [x] C2B
- [x] B2B
- [x] B2C
- [x] TRANSACTION STATUS
- [ ] ACCOUNT BALANCE
- [x] REVERSAL

## Requisites
We highly recommend reading Mpesa API [docs](https://developer.mpesa.vm.co.mz/) first!

You Will need a few things from there before development.

1. Api Key
2. Public Key

- Login or Register as a M-Pesa developer [here](https://developer.mpesa.vm.co.mz/accounts/login/?next=/accounts/signup/) if you haven't.
- You will be issued with an API Key and a Public Key. You will use these to generate your access token.

## Getting Started

Add dependency in pubspec.yaml

```yaml
dependencies:
  mpesa_sdk_dart: [ADD_LATEST_VERSION_HERE]
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
MpesaTransaction.c2b(token, payload);
```

### Handle response

All you need is assigning your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async function

```dart
Response response = await MpesaTransaction.c2b(token, payload);
print(response.body);
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
MpesaTransaction.b2c(token, payload);
```

### Handle response

All you need is assigning your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async function

```dart
Response response = await MpesaTransaction.b2c(token, payload);
print(response.body);
```

### REVERSAL Api Call

#### Initialize your payload

```dart
ReversalRequest payload = ReversalRequest(
        inputInitiatorIdentifier: "MPesa2018",
        inputTransactionID: transactioID,
        inputSecurityCredential: "Mpesa2019",
        inputServiceProviderCode: "171717",
        inputReversalAmount: montant,
        inputThirdPartyReference: "11114");
```

#### Perform the api call

```dart
MpesaTransaction.reversal(token, payload);
```

### Handle response

All you need is assigning your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async function

```dart
Response response = await MpesaTransaction.reversal(token, payload);
    print(response.body);
```

### B2B Api Call

#### Initialize your payload

```dart
TransferRequest payload = TransferRequest(
        inputTransactionReference: 'T12344C',
        inputPrimaryPartyCode: '171717',
        inputAmount: inputAmount,
        inputThirdPartyReference: '11114',
        inputReceiverPartyCode: "979797");
```

#### Perform the api call

```dart
MpesaTransaction.b2b(token, payload);
```

### Handle response

All you need is assigning your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async function

```dart
    Response response = await MpesaTransaction.b2b(token, payload);
    print(response.body);
```

### TRANSACTION STATUS Api Call

#### Perform the api call

```dart
MpesaTransaction.getTransactionStatus(
        token, "11114", transactionId, "171717");
```

### Handle response

All you need is assigning your call to a property of type Response (From [http](https://pub.dev/packages/http) package). Note that this is an async function

```dart
   Response response = await MpesaTransaction.getTransactionStatus(
        token, "11114", transactionId, "171717");
print(response.body);
```

## Credits

| Contributors |
|--------------|
| [Ergito Vilanculos](https://github.com/realrgt) |

----------------------------

## Copyright and license

MIT License

Copyright (c) 2020 Ergito Vilanculos

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


