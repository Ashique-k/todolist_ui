

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addEmployeeDetails(Map<String,dynamic> employeeInfoMap,String id)async{
    return await FirebaseFirestore.instance
        .collection("client")
        .doc(id).
    set(employeeInfoMap);

  }

  //update employee
  Future updateEmployeeDetails( String id,Map<String,dynamic> updateInfo) async{

    return await FirebaseFirestore.instance.collection("client").doc(id).update(updateInfo);
  }

  //delete employee

  Future deleteEmployeeDetails( String id) async{

    return await FirebaseFirestore.instance.collection("client").doc(id).delete();
  }

}
