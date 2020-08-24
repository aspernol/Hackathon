import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';
import 'message_list.dart';
import 'register_page.dart';
import 'signin_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage(this._mainModel, {Key key, this.title, this.firestore})
      : super(key: key);

  final String title;
  final Firestore firestore;
  final MainModel _mainModel;
  //final FirebaseUser user;

  CollectionReference get messages => firestore.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Register"),
            trailing: Icon(Icons.person_add),
            onTap: () {
              //pop the Drawer menu itself. so if we go back we will be on the main page not on the menu.
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          ),
          ListTile(
            title: Text("Sign In"),
            trailing: Icon(Icons.person),
            onTap: () {
              //pop the Drawer menu itself. so if we go back we will be on the main page not on the menu.
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
          ),
          ListTile(
              title: Text("About"),
              trailing: Icon(Icons.info),
              onTap: () {
                MainModel mainModel =
                    Provider.of<MainModel>(context, listen: false);
                //the about dialog also opens the list of 3rd party components
                showAboutDialog(
                    context: context,
                    applicationVersion: mainModel.packageInfo.version,
                    // applicationIcon: Image.asset('assets/images/Applogo.png',
                    //     width: 25, height: 25),
                    applicationLegalese:
                        'Some legal text about my awesome app');
              }),
        ],
      )),
      body: MessageList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        tooltip: 'Add message',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addMessage() async {
    String user = 'Anonymous';
    if (_mainModel.user != null) {
      if (_mainModel.user.displayName != null) {
        user = _mainModel.user.displayName;
      } else {
        user = _mainModel.user.email;
      }
    }
    await messages.add(<String, dynamic>{
      'message': 'Hello hackathon users!',
      'created_at': FieldValue.serverTimestamp(),
      'created_by': user
    });
  }
}
