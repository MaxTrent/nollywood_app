class TokenModel {
  bool error;
  bool success;
  Data data;
  int code;
  String message;

  TokenModel({required this.error, required this.success, required this.data, required this.code, required this.message});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
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
  Tokens tokens;

  Data({required this.tokens});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tokens: Tokens.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokens': tokens.toJson(),
    };
  }
}

class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
