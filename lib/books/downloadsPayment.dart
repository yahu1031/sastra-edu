import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/misc/dimensions.dart';
import 'package:sastra_ebooks/misc/strings.dart';
import 'package:sastra_ebooks/services/images.dart';
import 'package:sastra_ebooks/services/responsive/sizeConfig.dart';

class DownloadPayment extends StatefulWidget {
  static const id = '/paymentScreen';
  @override
  _DownloadPaymentState createState() => _DownloadPaymentState();
}

class _DownloadPaymentState extends State<DownloadPayment> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(
                      'Choose',
                      style: GoogleFonts.baloo(
                        fontWeight: FontWeight.w500,
                        fontSize: 6 * SizeConfig.textMultiplier,
                      ),
                    ),
                    Text(
                      'your plan',
                      style: GoogleFonts.baloo(
                        fontWeight: FontWeight.w500,
                        fontSize: 6 * SizeConfig.textMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Dimensions.smallPadding),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 3.0 * SizeConfig.heightMultiplier,
                  runSpacing: 5.0 * SizeConfig.heightMultiplier,
                  children: [
                    PlanCard(price: 'Free', time: '7 days'),
                    PlanCard(price: '₹ 100', time: '1 month'),
                    PlanCard(price: '₹ 450', time: '6 months'),
                    PlanCard(price: '₹ 1000', time: '1 year'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.smallPadding),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey[200],
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        Images.upi,
                        scale: 10,
                      ),
                      Text(
                        'Pay with UPI',
                        style: GoogleFonts.baloo(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'See terms and conditions',
                style: GoogleFonts.baloo(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.largePadding),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    print("pay");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlueAccent,
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.baloo(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String price;
  final String time;
  const PlanCard({
    Key key,
    this.price,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(Dimensions.padding),
      height: 20 * SizeConfig.heightMultiplier,
      width: 20 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: 10 * SizeConfig.widthMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            time,
            style: GoogleFonts.poppins(
              fontSize: 4.5 * SizeConfig.widthMultiplier,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
