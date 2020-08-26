import 'package:flutter/material.dart';
import 'package:sastra_ebooks/components/appBarTitles/appBarTitle.dart';
import 'package:sastra_ebooks/components/customAppBar.dart';
import 'package:sastra_ebooks/components/customScaffold.dart';

class Credits extends StatelessWidget {
  static const String id = '/credits';
  static const List<String> credits = [
    'Icons made by Freepik from www.flaticon.com',
    'Icons made by icons8',
  ];

  const Credits({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        context,
        backButton: true,
        title: AppBarTitle('Credits'),
      ),
      body: ListView.builder(
        itemCount: credits.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              ListTile(
                focusColor: Colors.red,
                title: Text(credits[i]),
              ),
              Divider(
                height: 0,
              )
            ],
          );
        },
      ),
    );
  }
}
