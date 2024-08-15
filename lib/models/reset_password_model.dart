class ResetPasswordModel {
  bool error;
  bool success;
  int code;
  String message;

  ResetPasswordModel(
      {required this.error,
      required this.success,
      required this.code,
      required this.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
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
