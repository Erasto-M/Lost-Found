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
        title: const Text("Found items",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
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
                  return Card(
                    child: Container(
                      height: 420,
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
                                Colors.green.withOpacity(1.0),
                                Colors.greenAccent.withOpacity(1.0),
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
                              const  Center(
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage('Images/lost.jpg',),
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Founded by:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Usernmae'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Category:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Category'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Wrap(
                                children: [
                                  const Text("Description:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Item Description'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),

                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Item Name:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Item Name'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Lost Within:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Location'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Found on Date:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Found Date'],
                                    style: const TextStyle(color: Colors.white12,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),

                            ],
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
}
