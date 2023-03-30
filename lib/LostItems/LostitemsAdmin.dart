import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/Authentication/reusableWidgets1.dart';
class lostAdmin extends StatefulWidget {
  const lostAdmin ({Key? key}) : super(key: key);

  @override
  State<lostAdmin> createState() => _lostAdminState();
}

class _lostAdminState extends State<lostAdmin> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final categorycontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final locationcontroller = TextEditingController();
  final descrptioncontroller = TextEditingController();
  final CollectionReference  Lost_items = FirebaseFirestore.instance.collection('Lost_items');
  Future<void> Update([DocumentSnapshot? documentSnapshot])async{
    if(documentSnapshot != null){
      categorycontroller.text = documentSnapshot['Category'];
      namecontroller.text = documentSnapshot['Item Name'];
      datecontroller.text = documentSnapshot['Mising Date'].toString();
      locationcontroller.text = documentSnapshot['Location'];
      descrptioncontroller.text = documentSnapshot['Item Description'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          TextField(
          keyboardType: TextInputType.text,
          controller: categorycontroller,
          decoration: const InputDecoration(
          labelText: "Category",
          ),
          ),
          const SizedBox(
          height: 5,
          ),
          TextField(
          keyboardType: TextInputType.text,
          controller: datecontroller,
          decoration: const InputDecoration(
          labelText: "Mising Date",
          ),
          ),
          const SizedBox(
          height: 5,
          ),
          TextField(
          keyboardType: TextInputType.text,
          controller: locationcontroller,
          decoration: const InputDecoration(
          labelText: "Lost Within",
          ),
          ),
          const SizedBox(
          height: 5,
          ),
          TextField(
          keyboardType: TextInputType.text,
          controller: descrptioncontroller,
          decoration: const InputDecoration(
          labelText: "Item Description",
          ),
          ),
          const SizedBox(
          height: 5,
          ),
          TextField(
          keyboardType: TextInputType.text,
          controller: namecontroller,
          decoration: const InputDecoration(
          labelText: "Item Name",
          ),
          ),
          const SizedBox(
          height: 15,
          ),
          ElevatedButton(
          onPressed: () async {
          final String name = namecontroller.text;
          final String category = categorycontroller.text;
          final String date = datecontroller.text.toString();
          final String description = descrptioncontroller.text;
          final String location = locationcontroller.text;
          if (category != null||name != null||date != null|| description != null|| location!= null) {
          await Lost_items
              .doc(documentSnapshot!.id)
              .update({"Category": category, "Item Name": name , "Mising Date": date, "Location": location, "Item Description": description});
          categorycontroller.text = '';
          namecontroller.text = '';
          datecontroller.text = '';
          locationcontroller.text = '';
          descrptioncontroller.text = '';
          ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content: Text("updated member details",
          style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
          ),
          );
          }
          },
              child: const Text("Update")),
          ],
          ));
  });
  }
  Future<void> delete(String Lost_itemsId)async{
    await Lost_items.doc(Lost_itemsId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
    const   SnackBar(
      duration: Duration(seconds: 3),
        backgroundColor: Colors.lightGreen,
        content: Text("Successfully deleted  an item",
    style: TextStyle(color: Colors.red),
    ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update and Delete Lost Items",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: Lost_items.snapshots(),
            builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return const Text("There is an error");
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return Card(
                    child: Container(
                      height: 650,
                      width: MediaQuery.of(context).size.width,
                      decoration:  BoxDecoration(
                          borderRadius:const  BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.blue.withOpacity(1.0),
                                Colors.blueAccent.withOpacity(1.0),
                                Colors.deepPurpleAccent.withOpacity(1.0),
                                Colors.cyanAccent.withOpacity(1.0),

                              ]
                          )
                      ),
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Center(
                                child: Row(
                                  children: [
                                  Center(
                                    child: Container(
                                      height: 200,
                                      width: 310,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Image.network(document['Image'],
                                      fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Category:", style: TextStyle(color: Colors.black,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Category'],
                                    style: const TextStyle(color: Colors.black54,
                                        fontWeight: FontWeight.normal,fontSize: 20),),

                                ],
                              ),
                              Space(),
                              Wrap(
                                children: [
                                  const Text("Description:", style: TextStyle(color: Colors.black,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Item Description'],
                                    style: const TextStyle(color: Colors.black54,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),

                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Item Name:", style: TextStyle(color: Colors.black,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Item Name'],
                                    style: const TextStyle(color: Colors.black54,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Lost Within:", style: TextStyle(color: Colors.black,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Location'],
                                    style: const TextStyle(color: Colors.black54,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Space(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Mising Date:", style: TextStyle(color: Colors.black,
                                      fontSize: 25,fontWeight: FontWeight.bold),),
                                  const SizedBox(width: 20,),
                                  Text(document['Mising Date'],
                                    style: const TextStyle(color: Colors.black54,
                                        fontWeight: FontWeight.normal,fontSize: 20),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      Update(document);
                                    },
                                    icon:const  Icon(Icons.edit,size: 30,color: Colors.white,),
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: (){
                                      delete(document.id);
                                    },
                                    icon:const  Icon(Icons.delete,size: 30,color: Colors.white,),
                                  ),
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                }).toList(),
              );
            }
        ),
      ),
    );
  }
}
