import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class Lost extends StatefulWidget {
  const Lost({Key? key}) : super(key: key);

  @override
  State<Lost> createState() => _LostState();
}

class _LostState extends State<Lost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost Page"),
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
                Bigtext(text: "Have you Lost an item an you want to Find it?"),
                Space(),
                Smalltext(text: "Fill in the details about the Item in the fields below"),
                const SizedBox(height: 30,),
                 TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    label: const Text("Item Category"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label: const Text("Item Name"),
                  ),
                ),
                const SizedBox(height: 10,),
                 TextFormField(
                  keyboardType: TextInputType.datetime,
                  maxLines: 1,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label: const Text("Missing Date"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label:const  Text("Location"),
                  ),
                ),
                const SizedBox(height: 10,),
                 TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label: const Text("Description of the Lost item"),
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  maxLines: 4,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label: const  Text("Any other relevant infomation about the  Item"),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (){},
                    child: const Text("Submit Details",
                    style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
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
