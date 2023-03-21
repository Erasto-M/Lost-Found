import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/Register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/Home/profile.dart';
import 'package:lostfound/LostItems/FetchlostItems.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Homepage'),
        centerTitle: true,
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
            ],
          ),
        )
      ),
    );
  }
}
