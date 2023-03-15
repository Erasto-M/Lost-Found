import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/Auth.dart';
import 'package:lostfound/Authentication/Register_screen.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  Bigtext(text: "SignIn"),
                  const SizedBox(height: 30,),
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
                          if(emailconteoller.text.isEmpty || passwordcontoller.text.isEmpty){
                             ScaffoldMessenger.of(context).showSnackBar(
                               const   SnackBar(
                                   backgroundColor: Colors.greenAccent,
                                   content: Text("Please fill in the fields",
                                     style: TextStyle(color: Colors.red),),
                                   duration: Duration(seconds: 2),
                                 )
                             );
                          }else {
                            await Authentication().Loginuser(
                                Email: emailconteoller.text,
                                password: passwordcontoller.text,
                              context: context,
                            );
                          }
                        },
                        child:const  Center(
                          child:  Text("Login",
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        )),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>const Register()));
                      },
                      child: const Text("Don't have anccount? Signup")),
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget _ischecked(){
    return const Text('hello');
  }
}
