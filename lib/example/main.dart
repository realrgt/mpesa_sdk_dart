import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mpesa_sdk_dart/example/MpesaKeys.dart';
import 'package:mpesa_sdk_dart/mpesa_sdk_dart.dart';
import 'package:mpesa_sdk_dart/src/mpesa_config.dart';
import 'package:mpesa_sdk_dart/src/mpesa_transaction.dart';
import 'package:mpesa_sdk_dart/src/output_response.dart';
import 'package:mpesa_sdk_dart/src/reversal_request.dart';
import 'package:mpesa_sdk_dart/src/transfer_request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mpse SDK Dart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = 'response';
  bool isPayEnabled = false;
  bool isCheckEnabled = false;
  String _montante;
  var _transactionID;
  OutputResponse outputResponse = OutputResponse();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_response),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                decoration: InputDecoration(helperText: "Insert the montant"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if (value.length != null) isPayEnabled = true;
                    _montante = value;
                  });
                },
              ),
            ),
//            Text(_montante),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text("Pay"),
                    onPressed: () {
                      isPayEnabled
                          ? pay(_montante)
                          : _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  new Text("Plese, insert a valid montant"),
                              duration: const Duration(milliseconds: 500)));
                    }),
                SizedBox(
                  width: 5,
                ),
                RaisedButton(
                    child: Text("Pay Business"),
                    onPressed: () {
                      isPayEnabled
                          ? sendToBusiness(_montante)
                          : _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content:
                                  new Text("Plese, insert a valid montant"),
                              duration: const Duration(milliseconds: 500)));
                    }),
              ],
            ),
            RaisedButton(
                child: Text("Take Back"),
                onPressed: () {
                  isCheckEnabled
                      ? takeBack(_montante, _transactionID)
                      : _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: new Text("Plese, try a payment first"),
                          duration: const Duration(milliseconds: 500)));
                }),
            RaisedButton(
                child: Text("See Status"),
                onPressed: () {
                  isCheckEnabled
                      ? getStatus(_transactionID)
                      : _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: new Text("Plese, try a payment first"),
                          duration: const Duration(milliseconds: 500)));
                })
          ],
        ),
      ),
    );
  }

  pay(var montante) async {
    print('called');
    String token = MpesaConfig.getBearerToken(
      '$apiKey_mpesa',
      '$publicKey_mpesa',
    );
    double valor = double.parse(montante);
    PaymentRequest payload = PaymentRequest(
      inputTransactionReference: 'T12344C',
      inputCustomerMsisdn: '258846738751',
      inputAmount: valor,
      inputThirdPartyReference: '11114',
      inputServiceProviderCode: '171717',
    );

    Response response = await MpesaTransaction.c2b(token, payload);
    print(response.body);
    outputResponse = responseFromJson(response.body);

    setState(() {
      _transactionID = outputResponse.outputTransactionID;
      isCheckEnabled = true;
    });
  }

  takeBack(montante, transactioID) async {
    print('called');
    String token = MpesaConfig.getBearerToken(
      '$apiKey_mpesa',
      '$publicKey_mpesa',
    );
//    double valor = double.parse(montante);
    ReversalRequest payload = ReversalRequest(
        inputInitiatorIdentifier: "MPesa2018",
        inputTransactionID: transactioID,
        inputSecurityCredential: "Mpesa2019",
        inputServiceProviderCode: "171717",
        inputReversalAmount: montante,
        inputThirdPartyReference: "11114");

    Response response = await MpesaTransaction.reversal(token, payload);
    print(response.body);
  }

  sendToCostumer(montante) async {
    print('called');
    String token = MpesaConfig.getBearerToken(
      '$apiKey_mpesa',
      '$publicKey_mpesa',
    );
    double valor = double.parse(montante);
    PaymentRequest payload = PaymentRequest(
      inputTransactionReference: 'T12344C',
      inputCustomerMsisdn: '258846738751',
      inputAmount: valor,
      inputThirdPartyReference: '11114',
      inputServiceProviderCode: '171717',
    );

    Response response = await MpesaTransaction.b2c(token, payload);
    print(response.body);
  }

  getStatus(transactionId) async {
    String token = MpesaConfig.getBearerToken(
      '$apiKey_mpesa',
      '$publicKey_mpesa',
    );

    Response response = await MpesaTransaction.getTransactionStatus(
        token, "11114", transactionId, "171717");
    setState(() {
      _response = response.body;
    });
  }

  sendToBusiness(montante) async {
    print('called');
    String token = MpesaConfig.getBearerToken(
      '$apiKey_mpesa',
      '$publicKey_mpesa',
    );
    double valor = double.parse(montante);
    TransferRequest payload = TransferRequest(
        inputTransactionReference: 'T12344C',
        inputPrimaryPartyCode: '171717',
        inputAmount: valor,
        inputThirdPartyReference: '11114',
        inputReceiverPartyCode: "979797");

    Response response = await MpesaTransaction.b2b(token, payload);
    print(response.body);
  }
}
