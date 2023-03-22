import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/Founditems/Fetchfoundadmin.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:path/path.dart' as path;
class Found extends StatefulWidget {
  const Found({Key? key}) : super(key: key);

  @override
  State<Found> createState() => _FoundState();
}

class _FoundState extends State<Found> {
  File? _photo;
  String? url;
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final categorycontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  final usernamecontroleer = TextEditingController();
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
  uploadImage(File image) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      String fileName = path.basename(image.path);
      Reference ref = storage.ref().child('Found/$fileName');
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
        title: const Text("Found Items",
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
                Center(child: Bigtext(text: "Did you find Something?")),
                Space(),
                Center(child: Bigtext(text: "Upload It Here")),
                Space(),
                TextFormField(
                  controller: usernamecontroleer,
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
                    label: const Text("Your Name"),
                  ),
                ),
                Space(),
                Center(child: Bigtext(text: 'Choose/Capture Image')),
                Space(),
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
                    label: const Text("Date Found"),
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
                    label:const  Text("Location From where you found it"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: descrptioncontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  maxLength: 20,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    label: const Text("Short Description of Found Item"),
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
                          usernamecontroleer.text.isEmpty||
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
                        await firestore.collection('Found_Items').doc().set({
                          'Image': url,
                          'Usernmae': usernamecontroleer.text,
                          'Category': categorycontroller.text,
                          'Item Name': namecontroller.text,
                          'Found Date': datecontroller.text.toString(),
                          'Location': locationcontroller.text,
                          "Item Description": descrptioncontroller.text,
                        });
                      }

                    },
                    child: const Text("Submit Item",
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const FetchAdmin()));
                    },
                    child: const Text("Access Item",
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

