import 'dart:convert';

TransferRequest transferRequestFromJson(String str) => TransferRequest.fromJson(json.decode(str));

String transferRequestToJson(TransferRequest data) => json.encode(data.toJson());

class TransferRequest {

  String inputTransactionReference;
  double inputAmount;
  String inputThirdPartyReference;
  String inputPrimaryPartyCode;
  String inputReceiverPartyCode;

  TransferRequest({
    this.inputTransactionReference,
    this.inputAmount,
    this.inputThirdPartyReference,
    this.inputPrimaryPartyCode,
    this.inputReceiverPartyCode,
  });

  TransferRequest.fromJson(Map<String, dynamic> json) {
    inputTransactionReference = json['input_TransactionReference'];
    inputAmount = json['input_Amount'];
    inputThirdPartyReference = json['input_ThirdPartyReference'];
    inputPrimaryPartyCode = json['input_PrimaryPartyCode'];
    inputReceiverPartyCode = json['input_ReceiverPartyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_TransactionReference'] = this.inputTransactionReference;
    data['input_Amount'] = this.inputAmount;
    data['input_ThirdPartyReference'] = this.inputThirdPartyReference;
    data['input_PrimaryPartyCode'] = this.inputPrimaryPartyCode;
    data['input_ReceiverPartyCode'] = this.inputReceiverPartyCode;
    return data;
  }
  
}
