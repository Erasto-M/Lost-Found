import 'package:flutter/material.dart';
import 'package:lostfound/Found.dart';
import 'package:lostfound/Lost.dart';
import 'package:lostfound/profile.dart';
import '../Home.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedindex = 0;
  static  List<Widget> widgetoptions = <Widget>[
    const Home(),
    const  Lost(),
    const Found(),
    //const Profile(),
  ];
  void onitemtap(int index){
    setState(() {
      selectedindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Members pages"),
      //   centerTitle: true,
      // ),
      body: widgetoptions.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label: "Home",
            //backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_replace),
            label: "Lost",
            //backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "Found",
            //backgroundColor: Colors.blue,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: "Profile",
          //   //backgroundColor: Colors.blue,
          // ),
        ],
        //type: BottomNavigationBarType.shifting,
        currentIndex: selectedindex,
        iconSize: 20,
       // fixedColor: Colors.blue,
        onTap: onitemtap,
        elevation: 5,

      ),
    );
  }
}
