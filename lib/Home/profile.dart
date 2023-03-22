import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final CollectionReference Users = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Users.snapshots(),
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
              children: snapshot.data!.docs.where((doc) => doc.id == 'Users')
                  .map((DocumentSnapshot document) {
                return Card(
                  child: Container(
                    height: 550,
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
                            Center(
                              child: Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(document['Image'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            Text(document['Firstname'],
                                  style: const TextStyle(color: Colors.white70,
                                      fontWeight: FontWeight.normal,fontSize: 20),),

                            Space(),
                            Text(document['Lastname'],
                              style: const TextStyle(color: Colors.white70,
                                  fontWeight: FontWeight.normal,fontSize: 20),),

                            Space(),
                            Text(document['Email'],
                              style: const TextStyle(color: Colors.white70,
                                  fontWeight: FontWeight.normal,fontSize: 20),),

                            Space(),
                            Text(document['PhoneNumber'],
                              style: const TextStyle(color: Colors.white70,
                                  fontWeight: FontWeight.normal,fontSize: 20),),
                            Space(),
                            Text(document['Registration Date'],
                              style: const TextStyle(color: Colors.white70,
                                  fontWeight: FontWeight.normal,fontSize: 20),),
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
    );
  }
}

