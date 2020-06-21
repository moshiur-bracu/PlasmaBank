import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:PlasmaBank/screens/Donor/receiver_model.dart';

class ReceiverDatabaseService {

  final String uid;
  ReceiverDatabaseService({ this.uid });

  //collection reference
  final CollectionReference receiverCollection = Firestore.instance.collection('Plasma Requests');

  Future updateUserData(String id, String name, String contactNumber, String bloodGroup, String city, String accpeted) async {
    return await receiverCollection.document(uid).setData({
      'id': id,
      'name': name,
      'contactNumber': contactNumber,
      'bloodGroup': bloodGroup,
      'city': city,
      'accepted': accpeted,
    });
  }

  Future updateUserDataAccepted(String accpeted) async {
    return await receiverCollection.document(uid).setData({
      'accepted': accpeted,
    }, merge: true);
  }

  // Receiver List from snapshot
  List<ReceiverModel> _receiverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return ReceiverModel(
        id: doc.data['id'] ?? '',
        name: doc.data['name'] ?? '',
        contactNumber: doc.data['contactNumber'] ?? '',
        bloodGroup: doc.data['bloodGroup'] ?? '',
        city: doc.data['city'] ?? '',
        accepted: doc.data['accepted'] ?? '',
      );
    }).toList();
  }

  //get receiverCollection stream
  Stream<List<ReceiverModel>> get receivers {
    return receiverCollection.snapshots()
    .map(_receiverListFromSnapshot);
  }

  Stream<List<ReceiverModel>> fetchReceiversBloodGroups(String bloodGroup) {
    return receiverCollection.where('bloodGroup', isEqualTo: bloodGroup)
           .snapshots().map(_receiverListFromSnapshot);
  }

  Stream<List<ReceiverModel>> fetchReceiversCities(String city) {
    return receiverCollection.where('city', isEqualTo: city)
           .snapshots().map(_receiverListFromSnapshot);
  }

}