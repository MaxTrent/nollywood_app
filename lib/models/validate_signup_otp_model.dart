class ValidateOtpModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  ValidateOtpModel({required this.error, required this.success, required this.data,required  this.code,required  this.message});

  factory ValidateOtpModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpModel(
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
  String confirmationId;

  Data({required this.confirmationId});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      confirmationId: json['confirmationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'confirmationId': confirmationId,
    };
  }
}
