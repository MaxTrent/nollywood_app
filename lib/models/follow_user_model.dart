class FollowUserModel {
  bool error;
  bool success;
  int code;
  String message;

  FollowUserModel(
      {required this.error,
      required this.success,
      required this.code,
      required this.message});

  factory FollowUserModel.fromJson(Map<String, dynamic> json) {
    return FollowUserModel(
      error: json['error'],
      success: json['success'],
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'code': code,
      'message': message,
    };
  }
}
