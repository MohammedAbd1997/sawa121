import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;

  const CustomImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidget(image);
  }
}

Widget buildWidget(String url) {
  Image image = Image.network(
    url,
    width: 50,
    height: 50,
  );

  final ImageStream stream = image.image.resolve(ImageConfiguration.empty);

  stream.addListener(ImageStreamListener((info, call) {
    //you can also handle image loading
    //example: loading = false;//that's mean image is loaded
  }, onError: (dynamic exception, StackTrace? stackTrace) {
    image = Image.asset("assets/images/icon_doctor.png");
  }));

  return image;
}
