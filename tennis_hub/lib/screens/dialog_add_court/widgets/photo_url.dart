import 'package:flutter/material.dart';

class PhotoUrl extends StatelessWidget {
  String urlPhoto;
  PhotoUrl(this.urlPhoto);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(urlPhoto),
    );
  }
}
