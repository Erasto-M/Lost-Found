import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/Auth.dart';
import 'package:lostfound/Authentication/Login_screen.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Fnamecontroller = TextEditingController();
  final Lnamecontroller = TextEditingController();
  final emailconteoller = TextEditingController();
  final passwordcontoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
            right: 15,
            left: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 800,
                  decoration:const BoxDecoration(
                    image:  DecorationImage(
                      image: AssetImage('Images/lost.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ) ,
                ),
                       const  SizedBox(height: 20,),
                        Bigtext(text: "SignUp"),
                        const SizedBox(height: 30,),
                        Textfield(
                            text: 'Firstname',
                            controller: Fnamecontroller,
                            keyboardtype: TextInputType.text,
                            autocorrect: true,
                            icon: Icons.person,
                            obsecureText: false),
                        Space(),
                        Textfield(
                            text: 'Lastname',
                            controller: Lnamecontroller,
                            keyboardtype: TextInputType.text,
                            autocorrect: true,
                            icon: Icons.person,
                            obsecureText: false),
                        Space(),
                        Textfield(
                            text: 'Email',
                            controller: emailconteoller,
                            keyboardtype: TextInputType.emailAddress,
                            autocorrect: true,
                            icon: Icons.email,
                            obsecureText: false),
                        Space(),
                        Textfield(
                            text: 'Password',
                            controller: passwordcontoller,
                            keyboardtype: TextInputType.text,
                            autocorrect: true,
                            icon: Icons.lock,
                            obsecureText: true),
                        const SizedBox(height: 30,),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: ()async{
                                if(
                                Fnamecontroller.text.isEmpty||
                                    Lnamecontroller.text.isEmpty||
                                    emailconteoller.text.isEmpty||
                                    passwordcontoller.text.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     const  SnackBar(
                                        content:  Text("please fill in the fields",
                                          style: TextStyle(color: Colors.red),),
                                        backgroundColor: Colors.greenAccent,
                                        duration: Duration(seconds: 2),
                                      )
                                  );
                                }
                                else{
                                  await Authentication().registeruser(
                                      Firstname: Fnamecontroller.text,
                                      Lastname: Lnamecontroller.text,
                                      Email: emailconteoller.text,
                                      password: passwordcontoller.text,
                                    context: context,
                                  );
                                }
                              },
                              child:const  Center(
                                child:  Text("Register",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              )),
                        ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context)=>const Login()));
                    },
                    child: const Text('Already have an account? SignIn')),
                      ],
                    ),
          ),
                ),
              )
    );
  }
}
