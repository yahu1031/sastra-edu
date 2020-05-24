import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upi_india/upi_india.dart';
import '../../Services/Responsive/size_config.dart';
import '../../Services/paths.dart';
import 'package:shimmer/shimmer.dart';


class Buyacoke extends StatefulWidget {
  @override
  _BuyacokeState createState() => _BuyacokeState();
}

class _BuyacokeState extends State<Buyacoke> {
  var quantity = 1;
  var amount = 20;

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
      receiverUpiId: '***************',
      receiverName: 'Minnu',
      transactionRefId: 'TestingId',
      transactionNote: 'Not actual. Just an example.',
      amount: (amount * quantity).toDouble(),
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Wrap(
        direction: Axis.horizontal,
        spacing: 10.0,
        runSpacing: 20.0,
        children: apps.map<Widget>((UpiIndiaApp app) {
          return GestureDetector(
            onTap: () {
              _transaction = initiateTransaction(app.app);
              setState(() {});
            },
            child: Container(
              height: 70,
              width: 70,
              child: Column(
                children: <Widget>[
                  Image.memory(
                    app.icon,
                    height: 50,
                    width: 50,
                  ),
                  Text(app.name, style: GoogleFonts.notoSans(fontSize: 12.0),),
                ],
              ),
            ),
          );
        }).toList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Shimmer.fromColors(
          baseColor: Colors.blue[500],
          highlightColor: Colors.lightBlueAccent,
          child: Container(
            child: new Text(
              'Buy us a Coke',
              style: GoogleFonts.pacifico(
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.lightBlueAccent),
                        height: 75,
                        width: 75,
                        child: Center(
                            child: SvgPicture.asset(Images.coke,
                                height: 30.0, width: 30.0, color: Colors.white)),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.lightBlueAccent),
                        child: Row(children: <Widget>[
                          IconButton(
                              iconSize: 17.0,
                              icon: Icon(Icons.remove,
                                  color: Colors.white, size: 24.0),
                              onPressed: () {
                                adjustQuantity('MINUS');
                              }),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.notoSans(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            iconSize: 17.0,
                            icon:
                            Icon(Icons.add, color: Colors.white, size: 24.0),
                            onPressed: () {
                              adjustQuantity('PLUS');
                            },
                          ),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(height: 7 * SizeConfig.heightMultiplier),
                  Text(
                    '\₹' + (amount * quantity).toString(),
                    style: GoogleFonts.notoSans(
                        fontSize: 40.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 7 * SizeConfig.heightMultiplier),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      labelStyle: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlueAccent,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 7 * SizeConfig.heightMultiplier),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Feel free to comment',
                      labelStyle: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.lightBlueAccent,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 7 * SizeConfig.heightMultiplier),
                  Center(
                    child: Container(
                      width: 200.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 50.0,
                      child: GestureDetector(
                        onTap: () async {
                          showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: displayUpiApps(),
                              ),
                            );
                          });
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          shadowColor: Colors.lightBlueAccent.withOpacity(0.2),
                          color: Colors.lightBlueAccent,
                          elevation: 7.0,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(Images.coke,
                                    color: Colors.white, height: 20.0),
                                SizedBox(width: 10),
                                Text(
                                  'Buy us a coke',
                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context,
                        AsyncSnapshot<UpiIndiaResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: Text('An Unknown error has occurred'));
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
                        return CupertinoAlertDialog(
                          title: Text('Transaction details', style: TextStyle(color: Colors.lightBlue),),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Transaction Id: $txnId\n'),
                              Text('Response Code: $resCode\n'),
                              Text('Reference Id: $txnRef\n'),
                              Text('Status: $status\n'),
                              Text('Approval No: $approvalRef'),
                            ],
                          ),
                          actions: [
                            CupertinoDialogAction(child:Text("Ok")),
                          ],
                        );
                      } else
                        return Text(' ');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  adjustQuantity(pressed) {
    switch (pressed) {
      case 'PLUS':
        setState(() {
          quantity += 1;
        });
        return;
      case 'MINUS':
        setState(() {
          if (quantity != 0) {
            quantity -= 1;
          }
        });
        return;
    }
  }
}