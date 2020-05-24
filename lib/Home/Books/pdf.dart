import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sastra_ebooks/Services/paths.dart';

class Pdf extends StatefulWidget {
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: false,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('PDF Name'),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }
}
