import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostfound/LostItems/FetchlostItems.dart';
import 'package:lostfound/LostItems/LostitemsAdmin.dart';
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
}
