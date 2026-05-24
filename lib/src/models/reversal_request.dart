class ReversalRequest {
  ReversalRequest({
    required this.transactionId,
    required this.securityCredential,
    required this.initiatorIdentifier,
    required this.thirdPartyReference,
    required this.serviceProviderCode,
    this.reversalAmount,
  }) {
    _requireNonEmpty(transactionId, 'transactionId');
    _requireNonEmpty(securityCredential, 'securityCredential');
    _requireNonEmpty(initiatorIdentifier, 'initiatorIdentifier');
    _requireNonEmpty(thirdPartyReference, 'thirdPartyReference');
    _requireNonEmpty(serviceProviderCode, 'serviceProviderCode');

    if (reversalAmount != null && reversalAmount! <= 0) {
      throw ArgumentError.value(
        reversalAmount,
        'reversalAmount',
        'must be greater than zero when provided',
      );
    }
  }

  final String transactionId;
  final String securityCredential;
  final String initiatorIdentifier;
  final String thirdPartyReference;
  final String serviceProviderCode;
  final num? reversalAmount;

  factory ReversalRequest.fromJson(Map<String, dynamic> json) {
    return ReversalRequest(
      transactionId: (json['input_TransactionID'] as String?) ?? '',
      securityCredential: (json['input_SecurityCredential'] as String?) ?? '',
      initiatorIdentifier: (json['input_InitiatorIdentifier'] as String?) ?? '',
      thirdPartyReference: (json['input_ThirdPartyReference'] as String?) ?? '',
      serviceProviderCode: (json['input_ServiceProviderCode'] as String?) ?? '',
      reversalAmount: json['input_ReversalAmount'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'input_TransactionID': transactionId,
      'input_SecurityCredential': securityCredential,
      'input_InitiatorIdentifier': initiatorIdentifier,
      'input_ThirdPartyReference': thirdPartyReference,
      'input_ServiceProviderCode': serviceProviderCode,
    };

    if (reversalAmount != null) {
      data['input_ReversalAmount'] = reversalAmount;
    }

    return data;
  }

  static void _requireNonEmpty(String value, String name) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, name, 'must not be empty');
    }
  }
}
