class TransferRequest {
  TransferRequest({
    required this.transactionReference,
    required this.amount,
    required this.thirdPartyReference,
    required this.primaryPartyCode,
    required this.receiverPartyCode,
  }) {
    _requireNonEmpty(transactionReference, 'transactionReference');
    _requireNonEmpty(thirdPartyReference, 'thirdPartyReference');
    _requireNonEmpty(primaryPartyCode, 'primaryPartyCode');
    _requireNonEmpty(receiverPartyCode, 'receiverPartyCode');

    if (amount <= 0) {
      throw ArgumentError.value(amount, 'amount', 'must be greater than zero');
    }
  }

  final String transactionReference;
  final num amount;
  final String thirdPartyReference;
  final String primaryPartyCode;
  final String receiverPartyCode;

  factory TransferRequest.fromJson(Map<String, dynamic> json) {
    return TransferRequest(
      transactionReference:
          (json['input_TransactionReference'] as String?) ?? '',
      amount: (json['input_Amount'] as num?) ?? 0,
      thirdPartyReference: (json['input_ThirdPartyReference'] as String?) ?? '',
      primaryPartyCode: (json['input_PrimaryPartyCode'] as String?) ?? '',
      receiverPartyCode: (json['input_ReceiverPartyCode'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'input_TransactionReference': transactionReference,
        'input_Amount': amount,
        'input_ThirdPartyReference': thirdPartyReference,
        'input_PrimaryPartyCode': primaryPartyCode,
        'input_ReceiverPartyCode': receiverPartyCode,
      };

  static void _requireNonEmpty(String value, String name) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, name, 'must not be empty');
    }
  }
}
