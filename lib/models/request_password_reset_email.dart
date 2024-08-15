class RequestPasswordResetModel {
  bool error;
  bool success;
  int code;
  String message;

  RequestPasswordResetModel({required this.error, required this.success, required this.code, required this.message});

  factory RequestPasswordResetModel.fromJson(Map<String, dynamic> json) {
    return RequestPasswordResetModel(
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
