import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Updatestudentpage.dart';
import 'addstudentpage.dart';

class ListStudentpage extends StatefulWidget {
  const ListStudentpage({Key? key}) : super(key: key);

  @override
  State<ListStudentpage> createState() => _ListStudentpageState();
}

class _ListStudentpageState extends State<ListStudentpage> {

  final Stream<QuerySnapshot> studentstream = FirebaseFirestore.instance
      .collection('students').snapshots();
    CollectionReference students = FirebaseFirestore.instance
        .collection('students');
   Future<void> deleteUser(id) {
    return students
        .doc(id)
        .delete()
        .then((value) => print("user delete"))
        .catchError((error)=> print('failed to user delete: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: studentstream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("something wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()
            );
          }
          final List storedocs =[];
          snapshot.data!.docs.map((DocumentSnapshot document){
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          }).toList();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                      children: [
                        TableCell(child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text('Name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight
                                  .bold),),
                          ),
                        )),
                        TableCell(child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text('Email',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight
                                  .bold),),
                          ),
                        )),
                        TableCell(child: Container(
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text('Action',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight
                                  .bold),),
                          ),
                        ))
                      ]
                  ),
                  for(var i = 0;i<storedocs.length; i++ )...[
                  TableRow(
                      children: [
                        TableCell(child: Container(

                          child: Center(
                            child: Text(storedocs[i]['name'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight
                                  .bold),),
                          ),
                        )),
                        TableCell(child: Container(

                          child: Center(
                            child: Text(storedocs[i]['email'],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight
                                  .bold),),
                          ),
                        )),
                        TableCell(child: Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          Updatestudentpage(id:storedocs[i]['id']))),
                              icon: Icon(Icons.edit, color: Colors.orange,),
                            ),
                            IconButton(onPressed: ()=>{deleteUser(storedocs[i]['id'])},
                              icon: Icon(Icons.delete, color: Colors.orange,),)
                          ],
                        )
                        )
                      ]
                  )],
                ],
              ),
            ),
          );
        });
  }
}