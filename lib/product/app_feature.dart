import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color(0xFFb298dc);
  static Color secondaryColor = Colors.white;
}

class AppSize {
  static EdgeInsets primaryAppMargin = const EdgeInsets.only(top: 15, left: 15);
  static EdgeInsets primaryAppPadding = const EdgeInsets.all(15);
}



class AppSpacer extends StatelessWidget {
  const AppSpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}