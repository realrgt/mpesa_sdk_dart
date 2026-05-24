class MpesaResult<T> {
  const MpesaResult({
    required this.statusCode,
    required this.reasonPhrase,
    required this.data,
    required this.headers,
    required this.rawBody,
  });

  final int statusCode;
  final String reasonPhrase;
  final T data;
  final Map<String, String> headers;
  final String rawBody;

  bool get isHttpSuccess => statusCode >= 200 && statusCode <= 299;
}
