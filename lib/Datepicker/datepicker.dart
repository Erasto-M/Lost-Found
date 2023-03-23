import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Date extends StatefulWidget {
  const Date({Key? key}) : super(key: key);

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  final datecontroller = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay(hour: 2, minute: 30);
 // String dateformat = DateFormat("dd - MMMM - yyyy").format(dateformat as DateTime);
  void showtime(){
     showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()
    ).then((value) {
      setState(() {
        timeOfDay = value!;
      });
     });
  }
  // void showdate(){
  //   showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1800),
  //       lastDate: DateTime(2200),
  //   ).then((value) {
  //     setState(() {
  //       dateformat = value! as String;
  //     });
  //   });
  // }
  @override
  void initstate(){
    super.initState();
    datecontroller.text = '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Date picker"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: datecontroller,
                decoration: InputDecoration(
                  labelText: "Select date",
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
                    String dateformat = DateFormat("yyyy - MM - dd").format(pickeddate);
                    setState(() {
                      datecontroller.text = dateformat.toString();
                    });
                  }else{
                    print("No date selected");
                  }
                },
              ),
              MaterialButton(
                  onPressed:(){} ,
                  child: Text("Set Time"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}



