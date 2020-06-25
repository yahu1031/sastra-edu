import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Components/AppBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/Components/customAppBar.dart';
import 'package:sastra_ebooks/Components/customScaffold.dart';
import 'package:sastra_ebooks/Services/Responsive/size_config.dart';
import 'package:sastra_ebooks/Services/dialogs.dart';
import 'package:sastra_ebooks/Services/paths.dart';
import 'package:upi_india/upi_india.dart';

class BuyACoke extends StatefulWidget {
  static const id = '/buyACoke';
  @override
  _BuyACokeState createState() => _BuyACokeState();
}

class _BuyACokeState extends State<BuyACoke> {
  var quantity = 1;
  var amount = 20;
  String _name, _comment = '';

  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: '7989152378@ybl',
      receiverName: 'Minnu',
      transactionRefId: 'TestingId',
      transactionNote: '$_name \n' + '$_comment',
      amount: (amount * quantity).toDouble(),
      // amount: 1.00,
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
        children: apps.map<Widget>((UpiApp app) {
          return GestureDetector(
            onTap: () async {
              // _transaction = initiateTransaction(app.app);
              UpiResponse _transactionResult =
                  await initiateTransaction(app.app);

              showDialog(
                barrierDismissible: false,
                context: context,
                child: Center(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text('Transaction Details'),
                    content: Text(
                        'Transaction Id: ${_transactionResult.transactionId}\n'
                        'Response Code: ${_transactionResult.responseCode}\n'
                        'Reference Id: ${_transactionResult.transactionRefId}\n'
                        'Status: ${_transactionResult.status}\n'
                        'Approval No: ${_transactionResult.approvalRefNo}\n'),
                    actions: <Widget>[
                      Center(
                        child: FlatButton(
                          onPressed: () =>
                              Navigator.of(context).pop(DialogAction.abort),
                          child: const Text(
                            'Ok',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
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
                  Text(
                    app.name,
                    style: GoogleFonts.notoSans(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: AppBarTitle('Buy Us A Coke'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                                height: 30.0,
                                width: 30.0,
                                color: Colors.white)),
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
                            icon: Icon(Icons.add,
                                color: Colors.white, size: 24.0),
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
                    onChanged: (input) => setState(() => _name = input),
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
                    onChanged: (input) => setState(() => _comment = input),
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
                          if (_name == null || _name == "" || _name == " ") {
                            Dialogs.yesAbortDialog(context, 'Sorry 😞',
                                "We can't allow you to pay without entering your name.");
                          } else {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: displayUpiApps(),
                                  ),
                                );
                              },
                            );
                          }
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
                  Expanded(
                    flex: 2,
                    child: FutureBuilder(
                      future: _transaction,
                      // ignore: missing_return
                      builder: (BuildContext context,
                          AsyncSnapshot<UpiResponse> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('An Unknown error has occurred'));
                          }
                          UpiResponse _upiResponse;
                          _upiResponse = snapshot.data;
                          if (_upiResponse.error != null) {
                            String text = '';
                            switch (snapshot.data.error) {
                              case UpiError.APP_NOT_INSTALLED:
                                text = "Requested app not installed on device";
                                break;
                              case UpiError.INVALID_PARAMETERS:
                                text =
                                    "Requested app cannot handle the transaction";
                                break;
                              case UpiError.NULL_RESPONSE:
                                text =
                                    "requested app didn't returned any response";
                                break;
                              case UpiError.USER_CANCELLED:
                                text = "You cancelled the transaction";
                                break;
                            }
                            return Center(
                              child: Text(text),
                            );
                          }
                          String status = _upiResponse.status;
                          switch (status) {
                            case UpiPaymentStatus.SUCCESS:
                              print('Transaction Successful');
                              break;
                            case UpiPaymentStatus.SUBMITTED:
                              print('Transaction Submitted');
                              break;
                            case UpiPaymentStatus.FAILURE:
                              print('Transaction Failed');
                              break;
                            default:
                              print('Received an Unknown transaction status');
                          }
                        } else
                          return Text(' ');
                      },
                    ),
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
          if (quantity != 10) {
            quantity += 1;
          }
        });
        return;
      case 'MINUS':
        setState(() {
          if (quantity != 1) {
            quantity -= 1;
          }
        });
        return;
    }
  }
}
