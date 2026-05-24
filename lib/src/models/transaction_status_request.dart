class TransactionStatusRequest {
  TransactionStatusRequest({
    required this.thirdPartyReference,
    required this.queryReference,
    required this.serviceProviderCode,
  }) {
    _requireNonEmpty(thirdPartyReference, 'thirdPartyReference');
    _requireNonEmpty(queryReference, 'queryReference');
    _requireNonEmpty(serviceProviderCode, 'serviceProviderCode');
  }

  final String thirdPartyReference;
  final String queryReference;
  final String serviceProviderCode;

  Map<String, String> toQueryParameters() {
    return {
      'input_ThirdPartyReference': thirdPartyReference,
      'input_QueryReference': queryReference,
      'input_ServiceProviderCode': serviceProviderCode,
    };
  }

  static void _requireNonEmpty(String value, String name) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(value, name, 'must not be empty');
    }
  }
}
