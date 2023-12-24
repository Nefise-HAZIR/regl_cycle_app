import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regl_cycle_app/model/user.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget(
      {super.key,
      required this.modelUser,
      required this.leftedDays,
      required this.updateSelectedDates, required this.nextRegl,required this.daysDifference});
  final ModelUser modelUser;
  final int? leftedDays;
  final int? nextRegl;
  final int? daysDifference;
  final void Function(DateTimeRange dateTimeRange) updateSelectedDates;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.09,
              margin: const EdgeInsets.only(top: 15, left: 15),
              padding: const EdgeInsets.all(15),
              child: Text(
                "Welcome Back     ${modelUser.username}",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                        fontSize: 25, color: Color(0xFFb298dc))),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
              color: Color(0xFFb298dc),
              borderRadius: BorderRadius.all(Radius.circular(300))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  leftedDays == null
                      ? "Create your first period"
                      : "${leftedDays == 0 ? 'Your period is over, get well soon' : '$leftedDays days left until your period ends'} ",
                  style: GoogleFonts.lobster(
                      textStyle:
                          const TextStyle(fontSize: 35, color: Colors.white))),
              const SizedBox(
                height: 15,
              ),
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
                  child: Text("Edit Date",
                      style: GoogleFonts.lobster(
                          textStyle: const TextStyle(
                              fontSize: 25, color: Color(0xFFb298dc))))),
              const SizedBox(
                height: 15,
              ),
              Text(
                  nextRegl == null
                      ? "Loading..."
                      : "Next period in $nextRegl days",
                  style: GoogleFonts.lobster(
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white)))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20),
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.09,
              margin: const EdgeInsets.only(top: 15, left: 15),
              padding: const EdgeInsets.all(15),
              child: Text(
                daysDifference == null
                    ? "Loading..."
                    : "Last month your period lasts about $daysDifference days",
                style: GoogleFonts.lobster(
                    textStyle: const TextStyle(
                        fontSize: 15, color: Color(0xFFb298dc))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}