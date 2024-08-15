class LogoutModel {
  bool error;
  bool success;
  int code;
  String message;

  LogoutModel({required this.error, required this.success, required this.code, required this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
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
