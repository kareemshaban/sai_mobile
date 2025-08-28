class MessageLocalModel {
  String? message;
  String? image;

  MessageLocalModel({
    this.message,
    this.image,
  });

  factory MessageLocalModel.fromJson(Map<String, dynamic> json) {
    return MessageLocalModel(
      message: json['message'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'message': message,
      'image': image,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
