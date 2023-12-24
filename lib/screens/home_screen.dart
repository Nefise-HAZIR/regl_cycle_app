import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/screens/profile_screen.dart';
import 'package:regl_cycle_app/widget/body_widget.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ProfileScreen(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    );
                  }),
                );
              },
              icon: const Icon(
                Icons.person,
                size: 40,
                color: Color(0xFFb298dc),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isError
                ? const Center(
                    child: Text("Error"),
                  )
                : BodyWidget(
                    modelUser: modelUser!,
                    leftedDays: leftedDays,
                    updateSelectedDates: updateSelectedDates,
                    nextRegl: nextRegl,
                    daysDifference: daysDifference,
                  ),
      ),
    );
  }
}
