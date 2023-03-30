import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Fetchlost extends StatefulWidget {
  const Fetchlost({Key? key}) : super(key: key);

  @override
  State<Fetchlost> createState() => _FetchlostState();
}

class _FetchlostState extends State<Fetchlost> {
  final CollectionReference  Lost_items = FirebaseFirestore.instance.collection('Lost_items');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text("All Lost Items",
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
          stream: Lost_items.snapshots(),
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
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return GestureDetector(
                  onTap:(){ showAlertDialog(context,document);},
                  child: Card(
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
                            Colors.white.withOpacity(1.0),
                            Colors.white12.withOpacity(0.4),
                            Colors.white.withOpacity(0.6),
                          ]
                        )
                      ),
                      child: Center(
                        child: GestureDetector(
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
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                 ),
                                 child:Image.network(document['Image'],
                                 fit: BoxFit.cover,
                                 )
                                ),
                              ),
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
                                    const Text("Mising Date:", style: TextStyle(color: Colors.black,
                                        fontSize: 25,fontWeight: FontWeight.normal),),
                                    const SizedBox(width: 20,),
                                    Text(document['Mising Date'],
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
              .collection('Lost_items')
              .doc(document.id)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                title: Center(child: Text("Contact owner")),
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
                title: Center(child: Text("Contact owner")),
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
              title: Center(child: Text("Contact owner")),
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
                          document['Owner'],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.email_outlined,size: 30,),
                        SizedBox(
                          width: 10,
                        ),

                        Text(
                          document['Email'],
                          style: TextStyle(
                              color: Colors.black,
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
