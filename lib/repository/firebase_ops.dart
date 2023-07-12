import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/leaderboard/leaderboard.dart';
import '../models/user/userr.dart';

class FirebaseOperations {
  final db = FirebaseFirestore.instance;

  createUserRecord(Userr user) {
    final data = user.toJson();
  
    db.collection("Users").doc().set(data);
  }
  Future readUserRecord() async {
    await db.collection("Users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });

  }
  Future readSingleUserRecord(String id) async{
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });

  }

  updateUserRecord() {
    
  }
  deleteUserRecord() {
    
  }

  // RANK RECORDS
  createRankRecord() {
    
  }
  readRankRecord() {
    
  }
  updateRankRecord() {
    
  }
  deleteRankRecord() {
    
  }
  Stream<List<Leaderboard>> readStreamRankRecord() => FirebaseFirestore.instance
    .collection('Leaderboard')
    .orderBy('points')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => Leaderboard.fromJson(doc.data())).toList());

}

