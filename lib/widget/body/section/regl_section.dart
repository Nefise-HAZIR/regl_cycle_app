import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regl_cycle_app/product/app_feature.dart';

class ReglSection extends StatelessWidget {
  const ReglSection({
    super.key,
    required this.leftedDays,
    required this.updateSelectedDates,
    required this.nextRegl,
  });

  final int? leftedDays;
  final void Function(DateTimeRange dateTimeRange) updateSelectedDates;
  final int? nextRegl;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      color: AppColor.primaryColor,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin:AppSize.primaryAppMargin,
        padding:AppSize.primaryAppPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              leftedDays == null
                  ? "Create your first period"
                  : "${leftedDays == 0 ? 'Your period is over, get well soon' : '$leftedDays days left until your period ends'} ",
              style: GoogleFonts.lobster(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                        color: AppColor.secondaryColor, fontSize: 20),
              ),
            ),
            const AppSpacer(),
            ElevatedButton(
              onPressed: () async {
                final DateTimeRange? dateTimeRange =
                    await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));
                if (dateTimeRange != null) {
                  updateSelectedDates(dateTimeRange);
                }
              },
              child: Text(
                "Edit Date",
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      fontSize: 25, color: AppColor.primaryColor),
                ),
              ),
            ),
            const AppSpacer(),
            Text(
              nextRegl == null
                  ? "Loading..."
                  : "Next period in $nextRegl days",
              style: GoogleFonts.lobster(
                textStyle: TextStyle(
                    fontSize: 20, color: AppColor.secondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
