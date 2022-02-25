import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(184, 11, 75,1.0);
const greyColor = Color.fromRGBO(189, 189, 189,1.0);
const blackColor = Color.fromRGBO(33, 33, 33,1.0);

const primaryLightColor = Color.fromRGBO(234, 244, 251,1.0);
const redColor = Color.fromRGBO(196 , 82, 67,1.0);
const greenColor = Color.fromRGBO(7 , 181, 103,1.0);
const redLightColor = Color.fromRGBO(255 , 241, 241,1.0);
const secondColor = Color.fromRGBO(240, 184, 73,1.0);
const secondColorLight = Color.fromRGBO(247, 247, 245,1.0);
const googleColor = Color.fromRGBO(234, 67, 53,1.0);
const facebookColor = Color.fromRGBO(59, 89, 152,1.0);

Map<int, Color> mainColor =
{
  50 :const Color.fromRGBO(184, 11, 75, .1),
  100:const Color.fromRGBO(184, 11, 75, .2),
  200:const Color.fromRGBO(184, 11, 75, .3),
  300:const Color.fromRGBO(184, 11, 75, .4),
  400:const Color.fromRGBO(184, 11, 75, .5),
  500:const Color.fromRGBO(184, 11, 75, .6),
  600:const Color.fromRGBO(184, 11, 75, .7),
  700:const Color.fromRGBO(184, 11, 75, .8),
  800:const Color.fromRGBO(184, 11, 75, .9),
  900:const Color.fromRGBO(184, 11, 75,  1),
};

MaterialColor colorCustom = MaterialColor(0xFFB80B4B, mainColor);

const API_URL = 'https://salon.morse-it.org/api/';



