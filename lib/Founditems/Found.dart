import 'package:flutter/material.dart';
class Found extends StatefulWidget {
  const Found({Key? key}) : super(key: key);

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Found page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const  EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: const [
              Text("found Items"),
            ],
          ),
        ),
      ),
    );
  }
}
