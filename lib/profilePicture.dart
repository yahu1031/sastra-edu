import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  static String _imageUrl;
  static ProfilePicture _profilePicture;

  factory ProfilePicture({String imageUrl}) {
    if (imageUrl != null) {
      _imageUrl = imageUrl;
      _profilePicture = ProfilePicture._internal();
      return _profilePicture;
    } else if (_imageUrl != null) {
      return _profilePicture;
    }
    throw 'Can\'t retrive profile picture';
  }

  ProfilePicture._internal();

  getImage() {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: _imageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: _imageUrl,
    );
  }
}
