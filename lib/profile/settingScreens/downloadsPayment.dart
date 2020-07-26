import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/buttons/WrappedToggleButtons.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/headings/largeHeading.dart';
import 'package:sastra_ebooks/misc/customColors.dart';
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
  List<bool> isSelected = [
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: AppBarTitle(Strings.premiumString),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LargeHeading(
              text: 'Choose\nYour Plan',
              highlightText: ' .',
              size: HeadingSize.large,
            ),
            WrappedToggleButtons(
              onPressed: (int i) {
                setState(() {
                  isSelected[i] = true;
                  for (int j = 0; j < isSelected.length; j++) {
                    if (j != i) {
                      isSelected[j] = false;
                    }
                  }
                });
              },
              isSelected: isSelected,
              children: <Widget>[
                PlanCard(
                  price: null,
                  time: '7 days',
                ),
                PlanCard(
                  price: 100,
                  time: '1 month',
                ),
                PlanCard(
                  price: 450,
                  time: '6 months',
                ),
                PlanCard(
                  price: 1000,
                  time: '1 year',
                ),
              ],
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: Dimensions.borderRadius,
                border: Border.all(
                  color: CustomColors.veryLightGrey,
                  width: 2,
                ),
              ),
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
            Center(
              child: Text(
                'See terms and conditions',
                style: GoogleFonts.baloo(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[300],
                ),
              ),
            ),
            RoundedButton(
              labelText: 'Continue',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final int price;
  final String time;
  const PlanCard({
    @required this.price,
    @required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            price != null ? '₹ $price' : 'Free',
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
