class EndorsementModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  EndorsementModel(
      {required this.error,
      required this.success,
      required this.data,
      required this.code,
      required this.message});

  factory EndorsementModel.fromJson(Map<String, dynamic> json) {
    return EndorsementModel(
      error: json['error'],
      success: json['success'],
      data: Data.fromJson(json['data']),
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': data.toJson(),
      'code': code,
      'message': message,
    };
  }
}

class Data {
  String userId;
  String endorsedUser;
  String comment;
  int rating;
  String id;
  String createdAt;
  String updatedAt;

  Data(
      {required this.userId,
      required this.endorsedUser,
      required this.comment,
      required this.rating,
      required this.id,
      required this.createdAt,
      required this.updatedAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['user_id'],
      endorsedUser: json['endorsed_user'],
      comment: json['comment'],
      rating: json['rating'],
      id: json['_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'endorsed_user': endorsedUser,
      'comment': comment,
      'rating': rating,
      '_id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
