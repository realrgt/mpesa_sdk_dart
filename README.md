# mpesa_sdk_dart

[![Pub Version](https://img.shields.io/pub/v/mpesa_sdk_dart?color=blue)](https://pub.dev/packages/mpesa_sdk_dart)
![GitHub](https://img.shields.io/github/license/realrgt/mpesa_sdk_dart)

A modern, typed Dart SDK for M-Pesa API (Mozambique).

## Features

- C2B, B2C, B2B, Reversal, and Transaction Status operations
- Typed request/response models
- Typed exceptions for auth, API, network, and serialization failures
- One primary client API (`MpesaClient`) with explicit configuration

## Requirements

- Dart SDK `>=3.6.0 <4.0.0`
- M-Pesa API Key and Public Key from [M-Pesa Developer Portal](https://developer.mpesa.vm.co.mz/)

## Installation

```yaml
dependencies:
  mpesa_sdk_dart: <latest_version>
```

## Quick Start

```dart
import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';

Future<void> main() async {
  final client = MpesaClient(
    credentials: const MpesaCredentials(
      apiKey: 'YOUR_API_KEY',
      publicKey: 'YOUR_PUBLIC_KEY',
    ),
    environment: MpesaEnvironment.sandbox,
  );

  final response = await client.c2b(
    PaymentRequest(
      transactionReference: 'T12344C',
      customerMsisdn: '258847522988',
      amount: 10,
      thirdPartyReference: '11114',
      serviceProviderCode: '171717',
    ),
  );

  if (!response.data.isSuccessCode) {
    throw StateError('Transaction failed: ${response.data.outputResponseDesc}');
  }

  client.close();
}
```

## Error Handling

```dart
try {
  final result = await client.b2c(request);
  // success
} on MpesaAuthException catch (error) {
  // invalid credentials/authorization
} on MpesaApiException catch (error) {
  // non-2xx response from M-Pesa
} on MpesaNetworkException catch (error) {
  // timeout or connectivity
} on MpesaSerializationException catch (error) {
  // invalid/non-JSON response payload
}
```

## Migration from v2

- `MpesaConfig.getBearerToken(...)` is removed from public API. Token generation is handled internally by `MpesaClient`.
- `MpesaTransaction.*` static calls are replaced by instance methods on `MpesaClient`.
- Request model fields moved from `inputXxx` naming to clear Dart naming, while preserving the original API JSON keys internally.
- Methods now return `MpesaResult<MpesaApiResponse>` and throw typed exceptions instead of leaking raw `http.Response`.

## License

MIT
