import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';
import 'my_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //setup the connection to the firebase firestore
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'test',
    options: const FirebaseOptions(
      googleAppID: '1:859777096728:android:e24e48a174ef214ef7b76d',
      gcmSenderID: '79601577497',
      apiKey: 'AIzaSyDLk6coNx184Ij80dw7lWZAxuY014JibCY',
      projectID: 'hackathon-flutter-firebase',
    ),
  );
  final Firestore firestore = Firestore(app: app);

  MainModel mainModel = MainModel();
  runApp(ChangeNotifierProvider<MainModel>(
    child: MyApp(firestore),
    create: (BuildContext context) => mainModel,
  ));
}

class MyApp extends StatelessWidget {
  MyApp(this._firestore);

  final Firestore _firestore;

  @override
  Widget build(BuildContext context) {
    MainModel mainModel = Provider.of<MainModel>(context, listen: false);
    return MaterialApp(
        title: 'Firebase Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(mainModel,
            title: 'Firebase Demo Home Page', firestore: _firestore));
  }
}
