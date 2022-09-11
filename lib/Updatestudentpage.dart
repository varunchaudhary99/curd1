import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Updatestudentpage extends StatefulWidget {
  final String id ;
  const Updatestudentpage({Key? key,required this.id}) : super(key: key);

  @override
  State<Updatestudentpage> createState() => _UpdatestudentpageState();
}

class _UpdatestudentpageState extends State<Updatestudentpage> {

  /*var name="";
  var email="";
  var password ="";*/
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  CollectionReference students = FirebaseFirestore.instance
      .collection('students');
  Future<void> upadateUser(id,name,email,password){
return students
    .doc(id)
    .update({'name': name,'email': email,'password': password})
    .then((value) => print("user update"))
    .catchError((error)=> print('user update error:$error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child:
              FutureBuilder<DocumentSnapshot <Map <String,dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('students')
                    .doc(widget.id)
                    .get(),
          builder: (_,snapshot) {
            if (snapshot.hasError) {
              print("something wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()
              );
            }
            var data = snapshot.data!.data();
            var name = data!['name'];
            var email = data['email'];
            var password = data['password'];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      //keyboardType: TextInputType.text,
                      autofocus: false,
                      initialValue: name,
                      onChanged: (value)=> name= value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },


                      style: new TextStyle(fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(


                        // Here is key idea

                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      //keyboardType: TextInputType.text,
                      autofocus: false,
                      initialValue: email,
                      onChanged: (value)=> email= value,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name';
                        } else if (!value.contains('@')) {
                          return 'Please enter vaild Email';
                        }
                        return null;
                      },
                      style: new TextStyle(fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(


                        // Here is key idea

                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      //keyboardType: TextInputType.text,
                      autofocus: false,
                      initialValue: password,
                      onChanged: (value)=> password= value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your Password';
                        }
                        return null;
                      },

                      obscureText: true,

                      style: new TextStyle(fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(


                        // Here is key idea

                      ),),
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    //color: Color(0XFFFFB6C1),

                    child: ElevatedButton(

                      style: ButtonStyle(

                          backgroundColor: MaterialStateProperty.all(Colors
                              .green),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),

                              )
                          )
                      ), onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        upadateUser(widget.id,name,email,password);
                        Navigator.pop(context);
                      }

                      //SignIn(emailController.text.toString(), passwordController.text.toString(),context);
                    },
                      child: Text("Update", style: new TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),),
                  ),

                ],

              ),
            );
          }))));
          }



}
