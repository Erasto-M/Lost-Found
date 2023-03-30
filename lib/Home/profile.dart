import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_upload/file_upload.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // String? url;
  // FirebaseStorage storage = FirebaseStorage.instance;
  // File? _photo;
  //
  // final ImagePicker _picker = ImagePicker();
  // Future picfromgallery() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     } else {
  //       print("No image selected");
  //     }
  //   });
  // }
  // Future picFromcamera() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     } else {
  //       print("No image selected");
  //     }
  //   });
  // }
  // Future uploadFile() async {
  //   if (_photo == null) return;
  //   final Filename = basename(_photo!.path);
  //   final destination = 'files/$Filename';
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination).child('file/');
  //     await ref.putFile(_photo!);
  //
  //     //* get the link to the image
  //     await ref.getDownloadURL().then((value) {
  //       setState(() {
  //         url = value;
  //         print(url);
  //       });
  //     });
  //   } catch (e) {
  //     print("No file selected");
  //   }
  // }
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Users",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: FutureBuilder(
            //get profile
            future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("There is an error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              final data = snapshot.data!;
              return Card(
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.cyanAccent.withOpacity(1.0),
                            Colors.cyan.withOpacity(1.0),
                            Colors.indigoAccent.withOpacity(1.0),
                          ])),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              minRadius: 90,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(
                                  data['Images'],
                                ),
                                // child: Image.network(data['Image'],
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                            ),
                          ),
                          // Center(
                          //   child: Container(
                          //     height: 150,
                          //     width: MediaQuery.of(context).size.width,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //     child: Image.network(data['Image'],
                          //       fit: BoxFit.fitWidth,
                          //     ),
                          //   ),
                          // ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.verified_user,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                data['Firstname'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                data['Lastname'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Space(),
                          Wrap(
                            children: [
                              Icon(
                                Icons.mail,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                data['Email'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Space(),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                data['PhoneNumber'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Space(),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.cyanAccent,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'created:' + data['Registration Date'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
