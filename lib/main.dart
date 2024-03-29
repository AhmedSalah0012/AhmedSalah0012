import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/dirctory/homescreen.dart';
import 'package:todo/dirctory/tabs/editTab.dart';
import 'package:todo/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: HomeScreen.routeName ,
      routes: {
      HomeScreen.routeName:(context)=> HomeScreen(),
        EditTab.routename:(context)=>EditTab(),
      },
    );
  }
}

