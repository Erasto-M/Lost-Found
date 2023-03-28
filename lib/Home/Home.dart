import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lostfound/Authentication/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:lostfound/Authentication/welcome_screen.dart';
import 'package:lostfound/Home/profile.dart';
import 'package:lostfound/LostItems/FetchlostItems.dart';

import '../LostItems/LostitemsAdmin.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TimeOfDay timeOfDay = TimeOfDay(hour: 2, minute: 30);
  DateTime dateTime = DateTime.now();
  final CollectionReference  Found_Items = FirebaseFirestore.instance.collection('Found_Items');
  final CollectionReference  Lost_items = FirebaseFirestore.instance.collection('Lost_items');
  void showtime(){
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((value) {
      setState(() {
        timeOfDay = value!;
      });
    });
  }
  void Showdate(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate:DateTime(1800) ,
        lastDate: DateTime(2200),
    ).then((value) {
      setState(() {
        dateTime = value!;
      });
    });
  }
  @override
  void initstate(){
    super.initState();
    datecontroller.text = '';
  }
  final datecontroller = TextEditingController();
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:GestureDetector(
          onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Fetchlost()));
          },
            child: const  Text('All Found Items')),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: ()async{
                await Authentication().signoutuser();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Welcome()));
              },
              icon: Icon(Icons.logout,size: 40,)),
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));
              },
              icon: Icon(Icons.person_outline,size: 40,)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
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
               scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return GestureDetector(
                  onTap: (){
                    showAlertDialog(context, document);
                  },
                  child: Card(
                    child: Container(
                      height: 450,
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
                                Colors.cyan.withOpacity(1.0),
                                Colors.cyanAccent.withOpacity(1.0),
                                Colors.deepPurpleAccent.withOpacity(1.0),
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
                                  height: 300,
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
                                  const Text("Found by:", style: TextStyle(color: Colors.white,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Username'],
                                    style: const TextStyle(color: Colors.black,
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
                                    style: const TextStyle(color: Colors.black,
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
                                    style: const TextStyle(color: Colors.black,
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
                                    style: const TextStyle(color: Colors.black,
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
                                    style: const TextStyle(color: Colors.black,
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
                                    style: const TextStyle(color: Colors.black,
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
      drawer: Drawer(
        backgroundColor: Colors.cyanAccent.withOpacity(1.0),
        child: Container(
          margin:const  EdgeInsets.only(
            top: 70,
          ),
          child: Column(
            children: [
              Text("My Profile Page", style: TextStyle(fontSize: 35),),
              SizedBox(height: 25,),
              GestureDetector(
                  onTap: (){
                    Showdate();
                  },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Text("Select Date" , style: TextStyle(color: Colors.black,fontSize: 25),),
                ),
              ),
              Container(
                height: 50,
                width: 200,
                color: Colors.white,
                child: MaterialButton(
                  onPressed:(){
                    showtime();
                  } ,
                  child: Text("Set Time", style: TextStyle(fontSize: 40,color: Colors.black),),
                ),
              ),
            ],
          ),
        )
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
                              color: Colors.green,
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
