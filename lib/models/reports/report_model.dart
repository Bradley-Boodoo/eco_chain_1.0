import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id, details;
  int numUp, numDown;

  ReportModel({
    required this.id,
    required this.details,
    required this.numUp,
    required this.numDown,
  });

  String get reportDetails => details;

  int get upVotes => numUp;
  Future<void> incrUpVotes() {
    CollectionReference coll = FirebaseFirestore.instance.collection('reports');

    return coll.doc(id).update({
      'upVotes': ++numUp,
    });
  }

  int get downVotes => numDown;
  Future<void> incrDownVotes() {
    CollectionReference coll = FirebaseFirestore.instance.collection('reports');

    return coll.doc(id).update({
      'downVotes': ++numDown,
    });
  }

  String get reportID => id;

  bool upSelected = false;
  bool get isUpSelected => upSelected;
  void setUpSelected() {
    upSelected = true;
  }

  bool downSelected = false;
  bool get isDownSelected => downSelected;
  void setDownSelected() {
    downSelected = true;
  }
}
