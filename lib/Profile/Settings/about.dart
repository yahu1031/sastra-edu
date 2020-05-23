import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_india_app.dart';
import 'package:upi_india/upi_india_response.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      appBar: new AppBar(
//        elevation: 0.0,
//        centerTitle: true,
//        backgroundColor: Colors.transparent,
//        title: Shimmer.fromColors(
//          baseColor: Colors.blue[500],
//          highlightColor: Colors.lightBlueAccent,
//          child: Container(
//            child: new Text(
//              'About Us',
//              style: GoogleFonts.pacifico(
//                fontSize: 30.0,
//              ),
//            ),
//          ),
//        ),
//        leading: IconButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          icon: Icon(
//            Icons.arrow_back_ios,
//            color: Colors.lightBlueAccent,
//          ),
//        ),
//      ),
//      body:Container(
//        child: Center(
//          child: Column(
//            children: <Widget>[
//              Text(""),
//              Text("hi"),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
  Future<UpiIndiaResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiIndiaApp> apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    super.initState();
  }

  Future<UpiIndiaResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: '7989152378@ybl',
      receiverName: 'Minnu',
      transactionRefId: 'TestingId',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Center(
        child: Wrap(
          children: apps.map<Widget>((UpiIndiaApp app) {
            return GestureDetector(
              onTap: () {
                _transaction = initiateTransaction(app.app);
                setState(() {});
              },
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.memory(
                      app.icon,
                      height: 60,
                      width: 60,
                    ),
                    Text(app.name),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI'),
      ),
      body: Column(
        children: <Widget>[
          displayUpiApps(),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: _transaction,
              builder: (BuildContext context,
                  AsyncSnapshot<UpiIndiaResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('An Unknown error has occured'));
                  }
                  UpiIndiaResponse _upiResponse;
                  _upiResponse = snapshot.data;
                  if (_upiResponse.error != null) {
                    String text = '';
                    switch (snapshot.data.error) {
                      case UpiIndiaResponseError.APP_NOT_INSTALLED:
                        text = "Requested app not installed on device";
                        break;
                      case UpiIndiaResponseError.INVALID_PARAMETERS:
                        text = "Requested app cannot handle the transaction";
                        break;
                      case UpiIndiaResponseError.NULL_RESPONSE:
                        text = "requested app didn't returned any response";
                        break;
                      case UpiIndiaResponseError.USER_CANCELLED:
                        text = "You cancelled the transaction";
                        break;
                    }
                    return Center(
                      child: Text(text),
                    );
                  }
                  String txnId = _upiResponse.transactionId;
                  String resCode = _upiResponse.responseCode;
                  String txnRef = _upiResponse.transactionRefId;
                  String status = _upiResponse.status;
                  String approvalRef = _upiResponse.approvalRefNo;
                  switch (status) {
                    case UpiIndiaResponseStatus.SUCCESS:
                      print('Transaction Successful');
                      break;
                    case UpiIndiaResponseStatus.SUBMITTED:
                      print('Transaction Submitted');
                      break;
                    case UpiIndiaResponseStatus.FAILURE:
                      print('Transaction Failed');
                      break;
                    default:
                      print('Received an Unknown transaction status');
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Transaction Id: $txnId\n'),
                      Text('Response Code: $resCode\n'),
                      Text('Reference Id: $txnRef\n'),
                      Text('Status: $status\n'),
                      Text('Approval No: $approvalRef'),
                    ],
                  );
                } else
                  return Text(' ');
              },
            ),
          )
        ],
      ),
    );
  }
}