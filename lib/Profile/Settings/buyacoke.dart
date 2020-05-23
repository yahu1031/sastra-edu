import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/Responsive/size_config.dart';
import '../../Services/paths.dart';
import 'package:shimmer/shimmer.dart';

import 'package:upi_india/upi_india.dart';

class Buyacoffee extends StatefulWidget {
  @override
  _BuyacoffeeState createState() => _BuyacoffeeState();
}

class _BuyacoffeeState extends State<Buyacoffee> {
  UpiIndia _upiIndia = UpiIndia();

  List<UpiIndiaApp> apps;

  var quantity = 1;

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
      app:
          apps[0].app, //  I took only the first app from List<UpiIndiaApp> app.
      receiverUpiId: '7989152378@ybl',
      receiverName: 'Minnu',
      transactionRefId: 'TestingId',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(width: 30.0,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lightBlueAccent),

                      child: Row(children: <Widget>[
                        IconButton(
                            iconSize: 17.0,
                            icon:
                                Icon(Icons.remove, color: Colors.white, size: 24.0),
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
                          icon: Icon(Icons.add, color: Colors.white, size: 24.0),
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
                  '\₹' + (20 * quantity).toString(),
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
//              initiateTransaction()
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
              ],
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
