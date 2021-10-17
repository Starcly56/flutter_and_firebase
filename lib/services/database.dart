import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_and_firebase/models/quote.dart';
import 'package:flutter_and_firebase/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({ required this.uid});

  // collection reference
  final CollectionReference flutterAndFirebaseCollection =
  FirebaseFirestore.instance.collection('fafCollection');

  Future updateUserData(String quote, String importance, String name,
      int reputation) async {
    return await flutterAndFirebaseCollection
        .doc(uid)
        .set({
      'quote': quote,
      'importance': importance,
      'name': name,
      'reputation': reputation
    });
  }

  // list of quotes
  List<Quote> _quoteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Quote(
          name: (doc.data() as dynamic)['name'] ?? '',
          quote: (doc.data() as dynamic)['quote'] ?? '',
          importance: (doc.data() as dynamic)['importance'] ?? '',
          reputation: (doc.data() as dynamic)['reputation'] ?? 0
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: (snapshot.data() as dynamic)['name'],
        quote: (snapshot.data() as dynamic)['quote'],
        importance: (snapshot.data() as dynamic)['importance'],
        reputation: (snapshot.data() as dynamic)['reputation']
    );
  }

  //get streams
  Stream<List<Quote>> get flutterAndFirebase {
    return flutterAndFirebaseCollection.snapshots().map(_quoteListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return flutterAndFirebaseCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}
