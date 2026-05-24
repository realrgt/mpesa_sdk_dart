import '../models/mpesa_api_response.dart';

class MpesaException implements Exception {
  const MpesaException(this.message);

  final String message;

  @override
  String toString() => 'MpesaException: $message';
}

class MpesaAuthException extends MpesaException {
  const MpesaAuthException(super.message, {required this.statusCode});

  final int statusCode;

  @override
  String toString() =>
      'MpesaAuthException(statusCode: $statusCode, message: $message)';
}

class MpesaNetworkException extends MpesaException {
  const MpesaNetworkException(super.message, {this.cause});

  final Object? cause;

  @override
  String toString() =>
      'MpesaNetworkException(message: $message, cause: $cause)';
}

class MpesaSerializationException extends MpesaException {
  const MpesaSerializationException(super.message, {required this.rawBody});

  final String rawBody;

  @override
  String toString() =>
      'MpesaSerializationException(message: $message, rawBody: $rawBody)';
}

class MpesaApiException extends MpesaException {
  const MpesaApiException({
    required this.statusCode,
    required this.response,
    required String message,
    required this.rawBody,
  }) : super(message);

  final int statusCode;
  final MpesaApiResponse response;
  final String rawBody;

  @override
  String toString() {
    return 'MpesaApiException(statusCode: $statusCode, code: ${response.outputResponseCode}, message: $message)';
  }
}
