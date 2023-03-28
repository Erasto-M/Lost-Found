import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/LostItems/LostitemsAdmin.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Lost extends StatefulWidget {
  const Lost({Key? key}) : super(key: key);

  @override
  State<Lost> createState() => _LostState();
}

class _LostState extends State<Lost> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final categorycontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  final phonenumbercontoller = TextEditingController();
  final ownercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  //* the link to the image
  String? url;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  //* refactored code for imagep picker
  getImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
          source: source, imageQuality: 70,);
      if (image != null) {
        _photo = File(image.path);
        setState(() {     
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //* refactored code to upload image to firebase storage and get the download url
  uploadImage(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = path.basename(image.path);
      Reference ref = storage.ref().child('lost/$fileName');
      await ref.putFile(image);
      url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOST ITEMS",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bigtext(text: "Have you Lost an item and you want to Find it?"),
                Space(),
                Smalltext(
                    text:
                        "Fill in the details about the Item in the fields below"),
                Space(),
                TextFormField(
                  controller: ownercontroller,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value!.isEmpty){
                      return " please Enter  your name";
                    } else{
                      return null;
                    }
                  },
                  maxLines: 1,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Owner Name"),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: emailcontroller,
                  validator: (value){
                    if(value!.isEmpty || !value.contains("@") ){
                      return "Enter a valid email Adress";
                    } else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  maxLength: 25,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Owner Email Address"),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: phonenumbercontoller,
                  keyboardType: TextInputType.number,
                  validator: (value){
                    if(value!.isEmpty || value.length < 10){
                      return "please enter a valid  phonenumber";
                    } else{
                      return null;
                    }
                  },
                  maxLines: 1,
                  maxLength: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Owner Phonenumber"),
                  ),
                ),
                SizedBox(height: 10,),
                Center(child: Bigtext(text: "Upload lost Item")),
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
                  child: Column(
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
                                        borderRadius:
                                            BorderRadius.circular(50)),
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: categorycontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Item Category"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: namecontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Item Name"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Select mising date",
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: ()async{
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2200));
                      if(pickeddate!=null){
                        String dateformat = DateFormat("dd - MM - yyyy").format(pickeddate);
                        setState(() {
                          datecontroller.text = dateformat.toString();
                        });
                      }else{
                        print("No date selected");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: locationcontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Location"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descrptioncontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  maxLength: 500,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    label: const Text("Description of the Lost item"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (categorycontroller.text.isEmpty ||
                          namecontroller.text.isEmpty ||
                          datecontroller.text.isEmpty ||
                          phonenumbercontoller.text.isEmpty||
                          locationcontroller.text.isEmpty ||
                          emailcontroller.text.isEmpty||
                          ownercontroller.text.isEmpty||
                          descrptioncontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text(
                                "Please fill all fields",
                                style: TextStyle(color: Colors.red),
                              )),
                        );
                      } else {
                        await firestore.collection('Lost_items').doc().set({
                          "Image": url,
                          'Category': categorycontroller.text,
                          'Item Name': namecontroller.text,
                          'Mising Date': datecontroller.text.toString(),
                          'Location': locationcontroller.text,
                          "Item Description": descrptioncontroller.text,
                          "Phonenumber": phonenumbercontoller.text.toString(),
                          "Owner": ownercontroller.text,
                          "Email": emailcontroller.text,
                        });
                      }
                    },
                    child: const Text(
                      "Submit Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
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
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const lostAdmin()));
                    },
                    child: const Text(
                      "Access Lost Items",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
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