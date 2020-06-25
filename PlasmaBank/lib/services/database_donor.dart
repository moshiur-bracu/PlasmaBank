import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

static Future<void> sendNotification(receiver) async {

    String token = 'eB-O2UCiSNmFn4JzV-Uz34:APA91bHvQ7mqxzID8qQ_47y7oZ1ndkqROOS1O4pJTqlXkY4xtQwVSZDcPeQ-vmfsI21m7OnV7gJ77tgOYP5BI1IsID_dcTsmnU0YTA2zuTwWrnbg851JscaTRU6xfgY_namKaiBPghqM';
    print('token : $token');

    final data = {
      "notification": {"body": "Please approve the request", "title": "New Donor Request"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAUqFAd9U:APA91bFgIxfbE2eoU2okcMlKginWO4X1qK9Ucs4sT9KayO68vDllUq-yHVHGahQaEn66F0A-geIhtCep8_y0alW9ruBEhH4VF2DxDIDUCGmrtBK1taYbBf1pVV3hXIJk7WogSYdoGahk'
    };


    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );


    try {
      final response = await Dio(options).post('https://fcm.googleapis.com/fcm/send',
          data: data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Success');
      } else {
        print('Unsuccessful Operation');
        // on failure do sth
      }
    }
    catch(e){
      print('exception $e');
    }




  }

  static Future<String> getToken(userId)async{

    final Firestore _db = Firestore.instance;

    var token;
    await _db.collection('Donor Lists')
        .document(userId)
        .collection('tokens').getDocuments().then((snapshot){
          snapshot.documents.forEach((doc){
            token = doc.documentID;
          });
    });

    return token;


  }


}
