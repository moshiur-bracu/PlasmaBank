import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DonorDatabaseService {

  final String uid;
  DonorDatabaseService({ this.uid });

  //collection reference
  final CollectionReference donorCollection = Firestore.instance.collection('Donor Lists');

  Future updateUserData(String name, String email, String contactNumber, String city, 
  String bloodGroup, String positiveDate, String negativeDate, String donationTimes, 
  String lastDonation, String newSymptoms, String viralDiseases, String pregnacyOrAbortion, String approval)
  async {
    return await donorCollection.document(uid).setData({
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
      'city': city,
      'bloodGroup': bloodGroup,
      'positiveDate': positiveDate,
      'negativeDate': negativeDate,
      'donationTimes': donationTimes,
      'lastDonation': lastDonation,
      'newSymptoms': newSymptoms,
      'viralDiseases': viralDiseases,
      'pregnancyOrAbortion': pregnacyOrAbortion,
      'approval': approval,
    });
  }

  //get receiverCollection stream
  Stream<QuerySnapshot> get donors {
    return donorCollection.snapshots();
  }

final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future saveDeviceToken(uid) async {

// Get the token for this device
String fcmToken = await _fcm.getToken();

// Save it to Firestore
if (fcmToken != null) {
  print(fcmToken);
  var tokens = _db
      .collection('Donor Lists')
      .document(uid)
      .collection('tokens')
      .document(fcmToken);

  await tokens.setData({
    'token': fcmToken,
    'createdAt': FieldValue.serverTimestamp(), // optional
    'platform': Platform.operatingSystem // optional
  });
}

}


}
