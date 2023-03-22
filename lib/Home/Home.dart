import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lostfound/Authentication/welcome_screen.dart';
import 'package:lostfound/Home/profile.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  // String? url;
  // FirebaseStorage storage = FirebaseStorage.instance;
  // File? _photo;
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Homepage'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: ()async{
                await Authentication().signoutuser();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Welcome()));
              },
              icon: Icon(Icons.transit_enterexit,size: 40,)),
          IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Profile()));
              },
              icon: Icon(Icons.person_outline,size: 40,)),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin :const  EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                Center(child: Text("Lost Items")),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.cyanAccent.withOpacity(1.0),
        child: Container(
          margin:const  EdgeInsets.only(
            top: 70,
          ),
          child: Column(
            children:   [
               Center(child: Text("My Profile",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),)),
              Divider(thickness: 2,color: Colors.green,),
              StreamBuilder<QuerySnapshot>(
                  stream: Users.snapshots(),
                  builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.where((doc) => doc.id == Users).map((DocumentSnapshot document) {
                        return Card(
                           child: Column(
                             children: [
                               // CircleAvatar(
                               //   maxRadius: 50,
                               //   backgroundColor: Colors.white,
                               //   child: CircleAvatar(
                               //     radius: 40,
                               //     child: Image.network(document['Image'],
                               //     fit: BoxFit.cover,
                               //     ),
                               //   ),
                               // ),
                               Text(document['Firstname']),
                             ],
                           ),
                        );

                      }).toList(),
                    );
                  }
              ),
            ],
          ),
        )
      ),
    );
  }
}
