import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHome {

  final CollectionReference homeCollection = Firestore.instance.collection('Home');

  //get homeCollection stream
  Stream<QuerySnapshot> get coronaUpdate {
    return homeCollection.snapshots();
  }

}