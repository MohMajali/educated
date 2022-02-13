import 'package:educatednearby/constant/configirations.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: getLang(context, "EducatedNearby"),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(45),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Regular'),
              ),
            ],
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(290),
        ),
      ],
    );
  }
}
