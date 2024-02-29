import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/product/app_feature.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({
    super.key,
    required this.modelUser,
  });

  final ModelUser modelUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.09,
        margin: AppSize.primaryAppMargin,
        padding: AppSize.primaryAppPadding,
        child: Text(
          "Welcome Back     ${modelUser.username}",
          style: GoogleFonts.lobster(
            textStyle:
                TextStyle(fontSize: 25, color: AppColor.primaryColor),
          ),
        ),
      ),
    );
  }
}