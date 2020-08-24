import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//this class represents the visual list of all database entries
//it registers the database query to receive updates from the database
//and builds the list of entries
class MessageList extends StatelessWidget {
  MessageList({this.firestore});

  final Firestore firestore;

  @override
  Widget build(BuildContext context) {
    //the StreamBuilder is called each time the firebase database sends updates
    return StreamBuilder<QuerySnapshot>(
      //create a new stream as a query and register it with the StreamBuilder so we get database updates
      stream: firestore
          .collection(
              "messages") //the name of the collection in the firestore database
          .orderBy("created_at", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //the snapshot contains the latest database snapshot
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;
        //create and display a new list of database entries
        return ListView.builder(
          itemCount: messageCount,
          //create a new itemBuilder that iterates over the database entries
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            final dynamic message = document['message'];
            final dynamic createdBy = document['created_by'];
            //create a visual element for each database entry
            return ListTile(
              trailing: IconButton(
                onPressed: () => document.reference.delete(),
                icon: Icon(Icons.delete),
              ),
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Created by: ' + createdBy.toString()),
            );
          },
        );
      },
    );
  }
}
