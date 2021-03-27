import 'dart:convert';

OutputResponse responseFromJson(String str) =>
    OutputResponse.fromJson(json.decode(str));

String responseToJson(OutputResponse data) => json.encode(data.toJson());

class OutputResponse {
  String? outputResponseCode;
  String? outputResponseDesc;
  String? outputTransactionID;
  String? outputConversationID;
  String? outputThirdPartyReference;
  String? outputResponseTransactionStatus;

  OutputResponse({
    this.outputResponseCode,
    this.outputResponseDesc,
    this.outputTransactionID,
    this.outputConversationID,
    this.outputThirdPartyReference,
    this.outputResponseTransactionStatus,
  });

  OutputResponse.fromJson(Map<String, dynamic> json) {
    outputResponseCode = json['output_ResponseCode'];
    outputResponseDesc = json['output_ResponseDesc'];
    outputTransactionID = json['output_TransactionID'];
    outputConversationID = json['output_ConversationID'];
    outputThirdPartyReference = json['output_ThirdPartyReference'];
    outputResponseTransactionStatus = json["output_ResponseTransactionStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['output_ResponseCode'] = this.outputResponseCode;
    data['output_ResponseDesc'] = this.outputResponseDesc;
    data['output_TransactionID'] = this.outputTransactionID;
    data['output_ConversationID'] = this.outputConversationID;
    data['output_ThirdPartyReference'] = this.outputThirdPartyReference;
    data['output_ResponseTransactionStatus'] =
        this.outputResponseTransactionStatus;

    return data;
  }
}
