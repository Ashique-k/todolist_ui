import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:todo_list/screens/dtls.dart';

import 'datasss.dart';

class Insert extends StatefulWidget {
  const Insert({super.key});

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  TextEditingController namectrl=TextEditingController();
  TextEditingController agectrl=TextEditingController();
  void _submitForm ()async{
    String Id = randomAlphaNumeric(10);
    Map<String, dynamic>employeeInfoMap = {
      'name':namectrl.text,
      'id':Id,
      'age': agectrl.text,

  };
    await DatabaseMethods().addEmployeeDetails(employeeInfoMap,Id)
        .then((value) {

      Fluttertoast.showToast(
          msg: "Employee details has been uploaded successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Details()),
    );
  }

  final SnackBar _snackBar = SnackBar(content: Text("succeesfully registerd"),duration: Duration(seconds: 4),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("TODO",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
            Text("LIST",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),

          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: namectrl,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: agectrl,
              decoration: InputDecoration(
                  hintText: "Age",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            _submitForm();


          }, child: Text("Add"))
        ],
      ),
    );

  }
}

