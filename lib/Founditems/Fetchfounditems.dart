import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_upload/file_upload.dart';
class Fetchfound extends StatefulWidget {
  const Fetchfound({Key? key}) : super(key: key);

  @override
  State<Fetchfound> createState() => _FetchfoundState();
}

class _FetchfoundState extends State<Fetchfound> {
  String? url;
  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;

  final ImagePicker _picker = ImagePicker();
  Future picfromgallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print("No image selected");
      }
    });
  }
  Future picFromcamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print("No image selected");
      }
    });
  }
  Future uploadFile() async {
    if (_photo == null) return;
    final Filename = basename(_photo!.path);
    final destination = 'files/$Filename';
    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_photo!);

      //* get the link to the image
      await ref.getDownloadURL().then((value) {
        setState(() {
          url = value;
          print(url);
        });
      });
    } catch (e) {
      print("No file selected");
    }
  }
  final CollectionReference  Found_Items = FirebaseFirestore.instance.collection('Found_Items');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        title: const Text("Found items",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: Found_Items.snapshots(),
            builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return const Text("There is an error");
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return GestureDetector(
                    onTap: (){
                      showAlertDialog(context, document);
                    },
                    child: Card(
                      child: Container(
                        height: 750,
                        width: MediaQuery.of(context).size.width,
                        decoration:  BoxDecoration(
                            borderRadius:const  BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Colors.white.withOpacity(1.0),
                                  Colors.white.withOpacity(1.0),
                                ]
                            )
                        ),
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
                                  child: Container(
                                    height: 250,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Image.network(document['IMAGE'],
                                    fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Found by:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Username'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),
                                Space(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Category:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Category'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),
                                Space(),
                                Wrap(
                                  children: [
                                    const Text("Description:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Item Description'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),

                                Space(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Item Name:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Item Name'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),
                                Space(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Lost Within:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Location'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),
                                Space(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Found on Date:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Found Date'],
                                      style: const TextStyle(color: Colors.black54,
                                          fontWeight: FontWeight.normal,fontSize: 20),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );

                }).toList(),
              );
            }
        ),
      ),
    );
  }
  void showAlertDialog(BuildContext context, DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Found_Items')
              .doc(document.id)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Center(child: Text("Contact Founder")),
                content: Container(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            }
            if (!snapshot.hasData) {
              return AlertDialog(
                title: Center(child: Text("Contact Founder")),
                content: Container(
                  height: 100,
                  child: Center(
                    child: Text("Unable to find phone number"),
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      MaterialButton(
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
            final data = snapshot.data?.data();
            //final phoneNumber = data['phoneNumber'];
            return AlertDialog(
              title: Center(child: Text("Contact founder")),
              content: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person,color: Colors.green,size: 30,),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          document['Username'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone_callback,color: Colors.green,size: 30,),
                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          document['Phonenumber'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        Icon(Icons.email_outlined,size: 30,),
                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          document['Email'],
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    MaterialButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(child: Container()),
                    MaterialButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
