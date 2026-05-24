class PaymentRequest {
  PaymentRequest({
    required this.transactionReference,
    required this.customerMsisdn,
    required this.amount,
    required this.thirdPartyReference,
    required this.serviceProviderCode,
  }) {
    _requireNonEmpty(transactionReference, 'transactionReference');
    _requireNonEmpty(customerMsisdn, 'customerMsisdn');
    _requireNonEmpty(thirdPartyReference, 'thirdPartyReference');
    _requireNonEmpty(serviceProviderCode, 'serviceProviderCode');

    if (amount <= 0) {
      throw ArgumentError.value(amount, 'amount', 'must be greater than zero');
    }
  }

  final String transactionReference;
  final String customerMsisdn;
  final num amount;
  final String thirdPartyReference;
  final String serviceProviderCode;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
      transactionReference:
          (json['input_TransactionReference'] as String?) ?? '',
      customerMsisdn: (json['input_CustomerMSISDN'] as String?) ?? '',
      amount: (json['input_Amount'] as num?) ?? 0,
      thirdPartyReference: (json['input_ThirdPartyReference'] as String?) ?? '',
      serviceProviderCode: (json['input_ServiceProviderCode'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'input_TransactionReference': transactionReference,
        'input_CustomerMSISDN': customerMsisdn,
        'input_Amount': amount,
        'input_ThirdPartyReference': thirdPartyReference,
        'input_ServiceProviderCode': serviceProviderCode,
      };

  static void _requireNonEmpty(String value, String name) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, name, 'must not be empty');
    }
  }
}
