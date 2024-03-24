import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  bool upSelected, downSelected;
  final String id, details;
  int numUp, numDown;

  ReportModel({
    required this.id,
    required this.details,
    required this.numUp,
    required this.numDown,
    required this.upSelected,
    required this.downSelected,
  });

  String get reportID => id;
  String get reportDetails => details;
  bool get isUpSelected => upSelected;
  bool get isDownSelected => downSelected;

  int get upVotes => numUp;
  Future<void> incrUpVotes() {
    CollectionReference coll = FirebaseFirestore.instance.collection('reports');
    upSelected = true;

    return coll.doc(id).update({'upVotes': ++numUp, 'upSelected': true});
  }

  int get downVotes => numDown;
  Future<void> incrDownVotes() {
    CollectionReference coll = FirebaseFirestore.instance.collection('reports');
    downSelected = true;

    return coll.doc(id).update({'downVotes': ++numDown, 'downSelected': true});
  }
}
