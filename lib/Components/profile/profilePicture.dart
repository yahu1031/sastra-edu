import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  static String _imageUrl;
  static ProfilePicture _profilePicture;

  factory ProfilePicture() {
    print('profilePictureConstructor ${ProfilePicture._profilePicture}');
    if (ProfilePicture._profilePicture != null) {
      return ProfilePicture._profilePicture;
    } else {
      throw 'Can\'t retrive profile picture. _profilePicture = $_profilePicture';
    }
  }

  ProfilePicture._internal();

  static updateImage(String imageUrl) {
    ProfilePicture._imageUrl = imageUrl;
    ProfilePicture._profilePicture = ProfilePicture._internal();
    print('updateProfilePicture ${ProfilePicture._profilePicture}');

    print(_imageUrl);
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
