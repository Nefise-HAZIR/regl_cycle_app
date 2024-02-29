import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regl_cycle_app/product/app_feature.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.daysDifference,
  });

  final int? daysDifference;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.09,
        margin: AppSize.primaryAppMargin,
        padding:AppSize.primaryAppPadding,
        child: Text(
          daysDifference == null
              ? "Loading..."
              : "Last month your period lasts about $daysDifference days",
          style: GoogleFonts.lobster(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                      color: AppColor.primaryColor, fontSize: 18)),
        ),
      ),
    );
  }
}
