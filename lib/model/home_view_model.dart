import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/screens/home_screen.dart';

abstract class HomeScreenViewModel extends State<HomeScreen>{
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  int? leftedDays;
  bool isLoading = true;
  bool isError = false;

  ModelUser? modelUser; //*

  DateTime? start;
  DateTime? end;
  DateTime? newStartTime;
  Duration? difference;
  int? daysDifference;
  int? nextRegl;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
          await firebaseFirestore.collection("users").doc(widget.uid).get();
      var userData = userSnap.data() as Map<String, dynamic>;
      modelUser = ModelUser.fromMap(
          userData); //* burdan verileri firebaseden çekerken sorun yaşıyor. firebase e veriler gidiyor

      diffrentDates();
      startTimer();
      nextReglDate();
      setState(() {});
    } catch (e) {
      isError = true;
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  startTimer() {
    DateTime now = DateTime.now();
    if (end != null && now.isBefore(end!)) {
      Duration difference = end!.difference(now);
      setState(() {
        leftedDays = difference.inDays;
      });
    } else {
      setState(() {
        leftedDays = -1;
      });
    }
  }

  nextReglDate() {
    newStartTime = end!.add(const Duration(days: 20));
    DateTime now = DateTime.now();
    if (newStartTime != null && now.isBefore(newStartTime!)) {
      Duration difference = newStartTime!.difference(now);
      setState(() {
        nextRegl = difference.inDays;
      });
    } else {
      setState(() {
        nextRegl = 0;
      });
    }
  }

  diffrentDates() {
    Timestamp? startTimestamp = modelUser!.startTime;
    Timestamp? endTimestamp = modelUser!.endTime;
    start = startTimestamp!.toDate();
    end = endTimestamp!.toDate();
    difference = end!.difference(start!);
    //print("difference");
    daysDifference = difference!.inDays;

    setState(() {
      leftedDays = daysDifference;
    });
  }

  void updateSelectedDates(DateTimeRange dateTimeRange) async {
    await firebaseFirestore.collection("users").doc(widget.uid).update({
      'selectedDates': {
        'start': dateTimeRange.start,
        'end': dateTimeRange.end,
      },
    });
    var userSnap =
        await firebaseFirestore.collection("users").doc(widget.uid).get();
    var userData = userSnap.data() as Map<String, dynamic>;
    modelUser = ModelUser.fromMap(userData);

    selectedDates = dateTimeRange;
    if (modelUser?.startTime != null && modelUser?.endTime != null) {
      diffrentDates();
      startTimer();
      nextReglDate();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error')));
    }
  }

}