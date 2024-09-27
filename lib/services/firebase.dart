import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  // get Collection name codes From Firebase
  CollectionReference codes = FirebaseFirestore.instance.collection('codes');


  // Create a new document in the collection

  Future<DocumentReference> createCode(String code) async {
    final DocumentReference documentReference =

    await codes.add({
      'code': code,
    });
    return documentReference;
  }


  // Get all the documents in the collection

  Stream<QuerySnapshot> getCodes()  {

    final getCodes = codes.snapshots();

    return getCodes;

  }
}