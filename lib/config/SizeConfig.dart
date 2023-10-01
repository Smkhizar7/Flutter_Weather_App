import 'package:flutter/material.dart';

class SizeConfig {
  static late double width;
  static late double height;
  init(context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  static double getProportionalWidth(double w) {
    return (w * width) / 100;
  }

  static double getProportionalHeight(double h) {
    return (h * height) / 100;
  }
}
