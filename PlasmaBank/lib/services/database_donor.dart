import 'package:cloud_firestore/cloud_firestore.dart';

class DonorDatabaseService {

  final String uid;
  DonorDatabaseService({ this.uid });

  //collection reference
  final CollectionReference donorCollection = Firestore.instance.collection('Donor Lists');

  Future updateUserData(String name, String email, String contactNumber, String city, 
  String bloodGroup, String positiveDate, String negativeDate, String donationTimes, 
  String lastDonation, String newSymptoms, String viralDiseases, String pregnacyOrAbortion)
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
    });
  }

  //get receiverCollection stream
  Stream<QuerySnapshot> get donors {
    return donorCollection.snapshots();
  }


}
