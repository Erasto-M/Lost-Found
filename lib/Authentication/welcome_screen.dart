 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostfound/Authentication/Register_screen.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 35,
              right: 20,
              left: 20,
            ),
            child: Column(
              children:  [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image:const  DecorationImage(
                      image: AssetImage('Images/lost.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Space(),
                Bigtext(
                    text:'Get your things Back  with '
                ),
                Text("LOST & FOUND",
               style: GoogleFonts.leckerliOne(color: Colors.greenAccent,
                   fontSize: 40,fontWeight: FontWeight.bold),
               ),
                GestureDetector(
                  child: Container(
                    height: 300,
                    width: 850,
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                          end:Alignment.topRight,
                          colors:[
                            Colors.blue.withOpacity(0.3),
                            Colors.lightBlue.withOpacity(0.3),
                          ]),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Get Started with any",
                          style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          ),
                         const  SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(child:
                                      Text("LOST",
                                      style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      )),
                                ),
                              ),
                             const  SizedBox(width: 20,),
                              Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(child:
                                  Text("FOUND",
                                  style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>Register()));
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient:const  LinearGradient(
                                  begin: Alignment.topLeft ,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.green,
                                      Colors.greenAccent,
                                      Colors.lightGreen,
                                      Colors.lightGreenAccent
                                    ]),
                              ),
                              child:const  Center(
                                child: Text("Get Started",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
