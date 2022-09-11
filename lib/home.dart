import 'package:flutter/material.dart';

import 'addstudentpage.dart';
import 'liststudentpage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: ()=>
                Navigator.push(context,MaterialPageRoute(builder: (context)=>
                    Addstudent())), child: Text('Add')),

          ],
        ),
      ),
     body: ListStudentpage(),
    );
  }
}
