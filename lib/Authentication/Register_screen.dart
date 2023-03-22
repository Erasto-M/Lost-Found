import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostfound/Authentication/Auth.dart';
import 'package:lostfound/Authentication/Login_screen.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:path/path.dart'as path;
import 'package:intl/intl.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _photo;
  String? url;
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Fnamecontroller = TextEditingController();
  final  datecontroller = TextEditingController();
  final phonenumber = TextEditingController();
  final Lnamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontoller = TextEditingController();
  getImage (ImageSource source) async{
    final Image = await _picker.pickImage(source: source, imageQuality:  70);
    try {
      if (Image != null) {
        _photo = File(Image.path);
        setState(() {});
      }
    }catch(e){
      debugPrint(e.toString());
    }
  }
  uploadImage(File Image)async{
    try{
      FirebaseStorage storage = FirebaseStorage.instance;
      String filename = path.basename(Image.path);
      Reference ref = storage.ref().child('USers/$filename');
      await ref.putFile(Image);
      url = await ref.getDownloadURL();
      return url;
    }catch (e){
      debugPrint(e.toString());
    }

  }
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
                Bigtext(text: "SignUp"),
                SizedBox(height: 20,),
                Text("Profile Image", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.cyanAccent,
                      child: _photo != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _photo!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                ),
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
                            controller:emailcontroller,
                            keyboardtype: TextInputType.emailAddress,
                            autocorrect: true,
                            icon: Icons.email,
                            obsecureText: false),
                        Space(),
                        Textfield(
                            text: "PhoneNumber",
                            controller: phonenumber,
                            keyboardtype: TextInputType.number,
                            autocorrect: false,
                            icon: Icons.dialpad,
                            obsecureText: false),
                        Space(),
                        Textfield(
                            text: "Registration date",
                            controller: datecontroller,
                            keyboardtype: TextInputType.text,
                            autocorrect: false,
                            icon: Icons.calendar_today,
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

                           ElevatedButton(
                              onPressed: ()async{
                                var user;
                                var userid = await FirebaseAuth.instance.currentUser;
                                if(
                                Fnamecontroller.text.isEmpty||
                                    Lnamecontroller.text.isEmpty||
                                    emailcontroller.text.isEmpty||
                                    datecontroller.text.isEmpty||
                                    phonenumber.text.isEmpty||
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
                                  await firestore.collection('Users').doc(userid?.uid).set({
                                    'Image': url,
                                    'Firstname': Fnamecontroller.text,
                                    'Lastname': Lnamecontroller.text,
                                    'Email': emailcontroller.text,
                                    'Registration Date':datecontroller.text.toString(),
                                    'PhoneNumber': phonenumber.text.toString(),
                                    'UserId': user.uid,
                                  });
                                  await Authentication().registeruser(
                                      Firstname: Fnamecontroller.text,
                                      Lastname: Lnamecontroller.text,
                                      Email: emailcontroller.text,
                                      password: passwordcontoller.text,
                                    context: context,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Account created Succesfully",
                                    style: TextStyle(color: Colors.red),
                                    )),
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
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () async {
                      await getImage(ImageSource.gallery);
                      await uploadImage(_photo!);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    await getImage(ImageSource.camera).then((value) {
                      uploadImage(_photo!);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
