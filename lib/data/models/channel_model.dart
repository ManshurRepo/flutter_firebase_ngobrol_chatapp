// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'user_model.dart';

class Channel {
  final String id;
  final List<String> memberIds;
  final String lastMessage;
  final Timestamp lastTime;
  final Map<String, bool> unRead;
  final List<UserModel> members;
  final String sendBy;
  Channel({
    required this.id,
    required this.memberIds,
    required this.lastMessage,
    required this.lastTime,
    required this.unRead,
    required this.members,
    required this.sendBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'memberIds': memberIds,
      'lastMessage': lastMessage,
      'lastTime': lastTime,
      'unRead': unRead,
      'members': members.map((user) => user.toMap()..['id'] = user.id).toList(),
      'sendBy': sendBy,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'] ?? '',
      memberIds: List<String>.from(map['memberIds']),
      lastMessage: map['lastMessage'] ?? '',
      lastTime: map['lastTime'] as Timestamp,
      unRead: map['unRead'],
      members: List<UserModel>.from(
        map['members']?.map((user) => UserModel.fromMap(user))),
      sendBy: map['sendBy'],
    );
  }
  factory Channel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Channel(
      id: snapshot.id, 
      memberIds: List<String>.from(snapshot['memberIds']),
      members: List<UserModel>.from(
          snapshot['members']?.map((user) => UserModel.fromMap(user))),
      lastMessage: snapshot['lastMessage'] ?? '', 
      lastTime: snapshot['lastTime'] as Timestamp, 
      unRead: Map<String, bool>.from(snapshot['unRead']),  
      sendBy: snapshot['sendBy'],
      );
  }
}
