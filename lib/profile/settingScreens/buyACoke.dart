/*
 Name: buyACoke
 Use:
 Todo:    - Add Use of this file
            - clean up some more
            - add some padding etc.
            - e.g. between the text fields
            - add validation method for form
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/textFields/customTextFormField/customTextFormField.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:upi_india/upi_india.dart';

import '../../services/dialogs.dart';
import '../../services/images.dart';

class BuyACoke extends StatefulWidget {
  static const id = '/buyACoke';
  @override
  _BuyACokeState createState() => _BuyACokeState();
}

class _BuyACokeState extends State<BuyACoke> {
  final _formKey = GlobalKey<FormState>();

  KeyboardVisibilityNotification _keyboardVisibility =
      new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardVisible;

  int quantity = 1;
  int amount = 20;
  String _name, _comment = '';

  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;

  @override
  void initState() {
    super.initState();
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    _keyboardVisible = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardVisible = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  Future<UpiResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: '7989152378@ybl',
      receiverName: 'Minnu',
      transactionRefId: 'TestingId',
      transactionNote: '$_name \n' + '$_comment',
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
                      borderRadius: Dimensions.borderRadius,
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

  validateInput() async {
    if (_formKey.currentState.validate()) {
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: AppBarTitle('Buy Us A Coke'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    height: 75,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                height: 30.0, width: 30.0, color: Colors.white),
                          ),
                        ),
                        Visibility(
                          visible: _keyboardVisible,
                          child: Text(
                            '\₹' + (amount * quantity).toString(),
                            style: GoogleFonts.notoSans(
                                fontSize: 40.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: Dimensions.borderRadius,
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
                  ),
                  Expanded(
                    child: Center(
                      child: Visibility(
                        visible: !_keyboardVisible,
                        child: Text(
                          '\₹' + (amount * quantity).toString(),
                          style: GoogleFonts.notoSans(
                              fontSize: 70.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ///*-----TextFormFields-----*///
                  CustomTextFormField(
                    labelText: 'Enter your name',
                    onChanged: (input) => setState(() => _name = input),
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    validator: (String _input) {
                      if (_input.isEmpty) {
                        return Strings.nameFieldEmptyString;
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  CustomTextFormField(
                    onChanged: (input) => setState(() => _comment = input),
                    labelText: 'Feel free to comment',
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  child: RoundedButton(
                    onPressed: validateInput,
                    labelText: 'Buy Us A Coke',
                  ),
                ),
              ),
            ),
//                    Expanded(
//                      flex: 2,
//                      child: FutureBuilder(
//                        future: _transaction,
//                        // ignore: missing_return
//                        builder: (BuildContext context,
//                            AsyncSnapshot<UpiResponse> snapshot) {
//                          if (snapshot.connectionState ==
//                              ConnectionState.done) {
//                            if (snapshot.hasError) {
//                              return Center(
//                                  child: Text('An Unknown error has occurred'));
//                            }
//                            UpiResponse _upiResponse;
//                            _upiResponse = snapshot.data;
//                            if (_upiResponse.error != null) {
//                              String text = '';
//                              switch (snapshot.data.error) {
//                                case UpiError.APP_NOT_INSTALLED:
//                                  text =
//                                      "Requested app not installed on device";
//                                  break;
//                                case UpiError.INVALID_PARAMETERS:
//                                  text =
//                                      "Requested app cannot handle the transaction";
//                                  break;
//                                case UpiError.NULL_RESPONSE:
//                                  text =
//                                      "requested app didn't returned any response";
//                                  break;
//                                case UpiError.USER_CANCELLED:
//                                  text = "You cancelled the transaction";
//                                  break;
//                              }
//                              return Center(
//                                child: Text(text),
//                              );
//                            }
//                            String status = _upiResponse.status;
//                            switch (status) {
//                              case UpiPaymentStatus.SUCCESS:
//                                print('Transaction Successful');
//                                break;
//                              case UpiPaymentStatus.SUBMITTED:
//                                print('Transaction Submitted');
//                                break;
//                              case UpiPaymentStatus.FAILURE:
//                                print('Transaction Failed');
//                                break;
//                              default:
//                                print('Received an Unknown transaction status');
//                            }
//                          } else
//                            return Text(' ');
//                        },
//                      ),
//                    )
          ],
        ),
      ),
    );
  }
}
