import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureProfile extends StatelessWidget {
  static String _imageUrl;
  static PictureProfile _profilePicture;

  factory PictureProfile() {
    if (_profilePicture != null) {
      return _profilePicture;
    }
    throw 'Can\'t retrive profile picture. _profilePicture = $_profilePicture';
  }

  PictureProfile._internal();

  static updateImage(String imageUrl) {
    _imageUrl = imageUrl;
    _profilePicture = PictureProfile._internal();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      useOldImageOnUrlChange: true,
    );
  }
}
