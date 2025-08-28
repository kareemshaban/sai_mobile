class LockedSeatLocalModel {
  int seatIndex;
  bool seatValue;
  String userID;

  LockedSeatLocalModel({
    required this.seatIndex,
    required this.seatValue,
    required this.userID,
  });

  factory LockedSeatLocalModel.fromJson(Map<String, dynamic> json) {
    return LockedSeatLocalModel(
      seatIndex: json['seatIndex'] ?? 0,
      seatValue: json['seatValue'] ?? false,
      userID: json['userID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatIndex': seatIndex,
      'seatValue': seatValue,
      'userID': userID,
    };
  }
}
