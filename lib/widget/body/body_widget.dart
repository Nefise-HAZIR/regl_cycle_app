import 'package:flutter/material.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/product/app_feature.dart';
import 'package:regl_cycle_app/widget/body/section/info_section.dart';
import 'package:regl_cycle_app/widget/body/section/regl_section.dart';
import 'package:regl_cycle_app/widget/body/section/welcome_section.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget(
      {super.key,
      required this.modelUser,
      required this.leftedDays,
      required this.updateSelectedDates,
      required this.nextRegl,
      required this.daysDifference});
  final ModelUser modelUser;
  final int? leftedDays;
  final int? nextRegl;
  final int? daysDifference;
  final void Function(DateTimeRange dateTimeRange) updateSelectedDates;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            WelcomeSection(modelUser: modelUser),
            const AppSpacer(),
            ReglSection(leftedDays: leftedDays, updateSelectedDates: updateSelectedDates, nextRegl: nextRegl),
            const AppSpacer(),
            InfoSection(daysDifference: daysDifference),
          ],
        ),
      ),
    );
  }
}





