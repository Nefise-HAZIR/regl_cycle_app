import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/resources/auth_methods.dart';
import 'package:regl_cycle_app/screens/login_screen.dart';
import 'package:regl_cycle_app/utils/image_helper.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic>?  userData;
  ModelUser? modelUser;
  Uint8List? _image;

  bool isError = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await firestore.collection("users").doc(widget.uid).get();
      userData = userSnap.data() ?? {};
      if (userData != null) {
        // && modelUser!.email.isEmpty ?? true
        modelUser = ModelUser.fromMap(userData??{});
      }
      getImage();
      setState(() {});
    } catch (e) {
      isError = true;
    }
  }

  getImage() {
    _image = ImageHelper.getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: userData == null || userData!.isEmpty 
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isError
              ? const Center(
                  child: Text("Error"),
                )
              : Center(
                  child: Column(
                    children: [
                      Flexible(flex: 2, child: Container()),
                      _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"),
                            ),
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        modelUser?.username == null
                            ? "Loading..."
                            : modelUser!.username,
                        style: const TextStyle(
                            color: Color(0xFF3a0ca3), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        modelUser?.email == null
                            ? "Loading..."
                            : modelUser!.email,
                        style: const TextStyle(
                            color: Color(0xFF3a0ca3), fontSize: 20),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            backgroundColor: const Color(0xFFb298dc)),
                        onPressed: () async {
                          await AuthMethods().signOut();
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        child: const Text(
                          "Log Out",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Flexible(flex: 2, child: Container()),
                    ],
                  ),
                ),
    );
  }
}
