/*
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:client_mohamoon/app/models/time_slot_model.dart';

typedef RoomAvailableCallBack = void Function(dynamic data);
typedef RemoteCandidateCallBack = void Function(
    dynamic candidate, dynamic sdpMid, dynamic sdpMLineIndex);

class VideoCallService {
  RoomAvailableCallBack? onRoomAvailable;
  RemoteCandidateCallBack? onGetRemoteCandidate;

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .delete();

    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';

class VideoCallService {
  var database = FirebaseDatabase.instance.ref();

  Future<String> getAgoraToken(String roomName) async {
    try {
      print("VVV");
      var callable = FirebaseFunctions.instance.httpsCallable('generateToken');
      print("XXX");
      print(roomName);
      print('publisher');
      final results = await callable({'channelName': roomName, 'role': 'publisher'});
      print("VVV");

      var clientSecret = results.data;
      print("VVV");

      return clientSecret;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .delete();
      //await database.child('room/' + roomName).remove();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createRoom(String roomId, Map<String, dynamic> roomData) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .set(roomData);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> isRoomExist(String roomId) async {
    try {
      var docRef = await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .where('roomId', isEqualTo: roomId)
          .get();
      if (docRef.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
