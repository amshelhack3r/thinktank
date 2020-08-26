import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:uuid/uuid.dart';
class User {
  String id;
  String name;
  String username;

  User(this.id, this.name, this.username);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'national_id': id,
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['national_id'];
    name = map['name'];
    username = map['username'];
  }

  User.fromSnapShot(DocumentSnapshot map) {
    id = map['national_id'];
    name = map['name'];
    username = map['username'];
  }
}

class Deposit {
  String id;
  String userId;
  int amount;
  List<String> months;
  int noOfMonths = 1;
  String picture;
  String date;

  Deposit(this.userId, this.amount, this.picture, this.noOfMonths, this.months) {
    var uuid = new Uuid();
    this.id = uuid.v1();
    this.date = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'picture': picture,
      'date': date,
      'noOfMonths': noOfMonths,
      'months': months
    };
  }
}

class Activity {}
