import 'package:flutter/material.dart';
import 'package:lostfound/Home/profile.dart';
import 'package:lostfound/LostItems/FetchlostItems.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Homepage'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Profile()));
              },
              icon: const Icon(Icons.person,size: 20,)),
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
    );
  }
}
