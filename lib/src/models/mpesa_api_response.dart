class MpesaApiResponse {
  const MpesaApiResponse({
    required this.outputResponseCode,
    required this.outputResponseDesc,
    this.outputTransactionId,
    this.outputConversationId,
    this.outputThirdPartyReference,
    this.outputResponseTransactionStatus,
    this.raw,
  });

  final String outputResponseCode;
  final String outputResponseDesc;
  final String? outputTransactionId;
  final String? outputConversationId;
  final String? outputThirdPartyReference;
  final String? outputResponseTransactionStatus;
  final Map<String, dynamic>? raw;

  bool get isSuccessCode => outputResponseCode == 'INS-0';

  factory MpesaApiResponse.fromJson(Map<String, dynamic> json) {
    return MpesaApiResponse(
      outputResponseCode: (json['output_ResponseCode'] as String?) ?? '',
      outputResponseDesc: (json['output_ResponseDesc'] as String?) ?? '',
      outputTransactionId: json['output_TransactionID'] as String?,
      outputConversationId: json['output_ConversationID'] as String?,
      outputThirdPartyReference: json['output_ThirdPartyReference'] as String?,
      outputResponseTransactionStatus:
          json['output_ResponseTransactionStatus'] as String?,
      raw: Map<String, dynamic>.from(json),
    );
  }
}
