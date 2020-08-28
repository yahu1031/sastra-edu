import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/buttons/wrappedToggleButtons.dart';
import 'package:sastra_ebooks/components/buttons/roundedButton/roundedButton.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';
import 'package:sastra_ebooks/components/headings/heading.dart';
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
  int currentPlan;
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: FittedBox(
                  child: Heading(
                    text2: 'Choose Your Plan',
                    highlightText: ' .',
                  ),
                ),
              ),
              WrappedToggleButtons(
                onPressed: (int i) {
                  setState(() {
                    if (currentPlan != null) {
                      isSelected[currentPlan] = false;
                    }
                    isSelected[i] = true;
                    currentPlan = i;
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.largePadding),
                child: Container(
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
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: Dimensions.extraLargePadding),
                child: Center(
                  child: Text(
                    'See terms and conditions',
                    style: GoogleFonts.lexendDeca(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
              RoundedButton(
                labelText: 'Pay',
                onPressed: () {},
              ),
            ],
          ),
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
      height: 18 * SizeConfig.heightMultiplier,
      width: 18 * SizeConfig.heightMultiplier,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            price != null ? '₹ $price' : 'Free',
            style: GoogleFonts.lexendDeca(
              fontSize: 10 * SizeConfig.widthMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            time,
            style: GoogleFonts.lexendDeca(
              fontSize: 4.5 * SizeConfig.widthMultiplier,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
