class ReportModel {
  final String details;
  int numUp, numDown;

  ReportModel({
    required this.numUp,
    required this.numDown,
    required this.details,
  });

  String get reportDetails => details;

  int get upVotes => numUp;
  void incrUpVotes() {
    numUp++;
  }

  int get downVotes => numDown;
  void incrDownVotes() {
    numDown++;
  }

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
