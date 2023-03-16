import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/Imagepic/Imagepick.dart';
import 'package:lostfound/LostItems/LostitemsAdmin.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path/path.dart';
class Lost extends StatefulWidget {
  const Lost({Key? key}) : super(key: key);

  @override
  State<Lost> createState() => _LostState();
}

class _LostState extends State<Lost> {
  storage.FirebaseStorage Storage = storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final categorycontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  Future picfromgallery()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        _photo = File(pickedFile.path);
        uploadFile();
      } else{
        print("No image selected");
      }
    });
  }
  Future picFromcamera()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        _photo = File(pickedFile.path);
        uploadFile();
      } else{
        print("No image selected");
      }
    });
  }
  Future uploadFile()async{
    if(_photo==null) return;
    final Filename = basename(_photo!.path);
    final destination = 'files/$Filename';
    try{
      final ref = storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    }
    catch(e){
      print("No file selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOST ITEMS",
        style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:const  EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Bigtext(text: "Have you Lost an item and you want to Find it?"),
                Space(),
                Smalltext(text: "Fill in the details about the Item in the fields below"),
                Space(),
                Center(child: Bigtext(text: "Upload lost Item")),
                Container(
                  padding: const  EdgeInsets.only(
                      top: 40,left: 30,right: 30
                  ),
                  child:Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: const Color(0xffFDCF09),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                 TextFormField(
                   controller: categorycontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    label: const Text("Item Category"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: namecontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: const Text("Item Name"),
                  ),
                ),
                const SizedBox(height: 10,),
                 TextFormField(
                   controller: datecontroller,
                  keyboardType: TextInputType.datetime,
                  maxLines: 1,
                  maxLength: 10,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: const Text("Missing Date"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: locationcontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label:const  Text("Location"),
                  ),
                ),
                const SizedBox(height: 10,),
                 TextFormField(
                   controller: descrptioncontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  maxLength: 100,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: const Text("Description of the Lost item"),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: ()async{
                      if(
                      categorycontroller.text.isEmpty||
                          namecontroller.text.isEmpty||
                      datecontroller.text.isEmpty||
                      locationcontroller.text.isEmpty||
                          descrptioncontroller.text.isEmpty
                      ){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                              content: Text("Please fill all fields",
                            style: TextStyle(color: Colors.red),
                          )),
                        );
                      }else{
                        await firestore.collection('Lost_items').doc().set({
                          'Category': categorycontroller.text,
                          'Item Name': namecontroller.text,
                          'Mising Date': datecontroller.text.toString(),
                          'Location': locationcontroller.text,
                          "Item Description": descrptioncontroller.text,
                        });
                      }

                    },
                    child: const Text("Submit Details",
                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Space(),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const lostAdmin()));
                    },
                    child: const Text("Access Lost Items",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30,),
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
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const  Text('Gallery'),
                      onTap: () {
                        picfromgallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading:  const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      picFromcamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
