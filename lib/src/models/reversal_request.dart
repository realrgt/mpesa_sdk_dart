import 'dart:convert';

ReversalRequest reversalRequestFromJson(String str) => ReversalRequest.fromJson(json.decode(str));

String reversalRequestToJson(ReversalRequest data) => json.encode(data.toJson());

class ReversalRequest {

  String? inputTransactionID;
  String? inputSecurityCredential;
  String? inputInitiatorIdentifier;
  String? inputThirdPartyReference;
  String? inputServiceProviderCode;
  double? inputReversalAmount;

  ReversalRequest({
    this.inputTransactionID,
    this.inputSecurityCredential,
    this.inputInitiatorIdentifier,
    this.inputThirdPartyReference,
    this.inputServiceProviderCode,
    this.inputReversalAmount,
  });

  ReversalRequest.fromJson(Map<String, dynamic> json) {
    inputTransactionID = json['input_TransactionID'];
    inputSecurityCredential = json['input_SecurityCredential'];
    inputInitiatorIdentifier = json['input_InitiatorIdentifier'];
    inputThirdPartyReference = json['input_ThirdPartyReference'];
    inputServiceProviderCode = json['input_ServiceProviderCode'];
    inputReversalAmount = json['input_ReversalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_TransactionID'] = this.inputTransactionID;
    data['input_SecurityCredential'] = this.inputSecurityCredential;
    data['input_InitiatorIdentifier'] = this.inputInitiatorIdentifier;
    data['input_ThirdPartyReference'] = this.inputThirdPartyReference;
    data['input_ServiceProviderCode'] = this.inputServiceProviderCode;
    data['input_ReversalAmount'] = this.inputReversalAmount;
    return data;
  }
  
}
