import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regl_cycle_app/model/home_view_model.dart';
import 'package:regl_cycle_app/screens/profile_screen.dart';
import 'package:regl_cycle_app/widget/body/body_widget.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenViewModel {
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
