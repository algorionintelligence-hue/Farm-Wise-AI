import 'package:flutter/material.dart';

class DeviceHelper {
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}

