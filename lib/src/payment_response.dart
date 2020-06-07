import 'dart:convert';

PaymentResponse responseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String responseToJson(PaymentResponse data) => json.encode(data.toJson());

class PaymentResponse {

  String outputResponseCode;
  String outputResponseDesc;
  String outputTransactionID;
  String outputConversationID;
  String outputThirdPartyReference;

  PaymentResponse({
    this.outputResponseCode,
    this.outputResponseDesc,
    this.outputTransactionID,
    this.outputConversationID,
    this.outputThirdPartyReference,
  });

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    outputResponseCode = json['output_ResponseCode'];
    outputResponseDesc = json['output_ResponseDesc'];
    outputTransactionID = json['output_TransactionID'];
    outputConversationID = json['output_ConversationID'];
    outputThirdPartyReference = json['output_ThirdPartyReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['output_ResponseCode'] = this.outputResponseCode;
    data['output_ResponseDesc'] = this.outputResponseDesc;
    data['output_TransactionID'] = this.outputTransactionID;
    data['output_ConversationID'] = this.outputConversationID;
    data['output_ThirdPartyReference'] = this.outputThirdPartyReference;
    return data;
  }
  
}
