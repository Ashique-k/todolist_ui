import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/add.dart';

import 'datasss.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController namesctrl=TextEditingController();
  TextEditingController agesctrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Insert()),
          );

        } ,child: Icon(Icons.add),),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("DETAIL",style: TextStyle(color: Colors.blue,
                fontSize: 24,fontWeight: FontWeight.bold),
            ),
            Text("LIST",style: TextStyle(color: Colors.black,
                fontSize: 24,fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
      body: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("client").snapshots(),
          builder: (context,AsyncSnapshot snapshot){
    if(snapshot.hasData){
      return ListView.builder(
        itemCount: snapshot.data.docs.length,
          itemBuilder:((BuildContext context,int index){
            final  DocumentSnapshot ds = snapshot.data.docs[index];
            return  Container(
                margin: EdgeInsets.only(bottom: 15),
            child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(8),
            child: Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),

            ),
              child: Column(
                children: [
                  Text(ds["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      namesctrl.text=ds["name"];
                      agesctrl.text=ds["age"];
                      EditDetails(ds["id"]);

                    },
                    child:  Icon(Icons.edit,
                      color: Colors.orange,
                      size: 25,)),
                SizedBox(
                  width: 10.0,
                ),
              GestureDetector(
                onTap: () async{
                  await DatabaseMethods().deleteEmployeeDetails(ds["id"]);

                },
                child: Icon(Icons.delete,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(ds["name"],style: TextStyle(color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 5,
                  ),
                  Text(ds["age"],style: TextStyle(color: Colors.blue,fontSize: 20.0,fontWeight: FontWeight.bold),),



                ],

              ),





            )
            )
            );

          }
          )

      );
    }
    return Container();




          }

          ),

    );
  }
  Future EditDetails(String id)=> showDialog(
      context: context,
      builder: (BuildContext context)=>AlertDialog(
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);

                },
              ),
              SizedBox(
                width: 40.0,
              ),
        Text("Edit",style: TextStyle(color: Colors.blue,
            fontSize: 24,fontWeight: FontWeight.bold),
        ),
        Text("Details",style: TextStyle(color: Colors.orange,
            fontSize: 24,fontWeight: FontWeight.bold),
        ),
              Text("Name",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.bold )),
              SizedBox(
                height: 10,

              ),
              Container(
                child: TextField(
                  controller: namesctrl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text("age",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: agesctrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              ElevatedButton(onPressed: ()async{
               Map<String,dynamic>updateInfo= {
                "name": namesctrl.text,
               "age": agesctrl.text,
               "id":id,
                };
               await DatabaseMethods().updateEmployeeDetails(id, updateInfo).then((value) {
                 Navigator.pop(context);
               });






              }, child: Text("update"))




            ],

          ),


        ),

      )
  );
}
