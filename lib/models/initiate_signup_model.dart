class InitiateSignUpModel {
  final bool error;
  final bool success;
  final dynamic data;
  final int code;
  final String message;

  InitiateSignUpModel({
    required this.error,
    required this.success,
    this.data,
    required this.code,
    required this.message,
  });

  factory InitiateSignUpModel.fromJson(Map<String, dynamic> json) {
    return InitiateSignUpModel(
      error: json['error'],
      success: json['success'],
      data: json['data'],
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'success': success,
      'data': data,
      'code': code,
      'message': message,
    };
  }
}
