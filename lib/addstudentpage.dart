import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({Key? key}) : super(key: key);

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {

  var name="";
  var email="";
  var password ="";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();

  }
  CollectionReference students = FirebaseFirestore.instance
      .collection('students');
 Future<void> addUser(){
    return students
        .add({'name': name,'email':email,'password':password})
        .then((value) => print("user add"))
        .catchError((error)=> print('failed to user add: $error'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  //keyboardType: TextInputType.text,
                  autofocus: true,

                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Enter your name';
                    }return null;
                  },
                  controller: nameController,
                  style: new TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Name',

                    // Here is key idea

                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  //keyboardType: TextInputType.text,
                  autofocus: true,


                  controller: emailController,
    validator: (value){
    if(value==null || value.isEmpty){
    return 'Enter your name';
    }else if(!value.contains('@')){
      return 'Please enter vaild Email';
    } return null;
    },
                  style: new TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Email',

                    // Here is key idea

                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  //keyboardType: TextInputType.text,
                  autofocus: true,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Enter your Password';
                    }return null;
                  },
                  obscureText: true,
                  controller: passwordController,
                  style: new TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Password',

                    // Here is key idea

                  ),),
              ),
              Container(
                height: 50,
                width: 300,
                //color: Color(0XFFFFB6C1),

                child: ElevatedButton(

                  style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          )
                      )
                  ),onPressed: () {
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        name = nameController.text;
                        email= emailController.text;
                        password=passwordController.text;
                        addUser();
                        clearText();
                      });
                    }

                  //SignIn(emailController.text.toString(), passwordController.text.toString(),context);
                },
                  child: Text("Register",style: new TextStyle(
                      fontSize: 20, color: Colors.white,fontWeight:FontWeight.normal)),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
