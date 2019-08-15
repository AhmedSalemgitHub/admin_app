import 'package:admin_app/ListDreams.dart';
import 'package:flutter/material.dart';


void main() async{

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream',
      home:
      //LoginPage()
      ListDreams(title: "تفسير الاحلام",),
    );
  }
}

