class LoginModel {
  bool error;
  bool success;
  Data? data;
  int code;
  String message;

  LoginModel({required this.error, required this.success, required this.data, required this.code, required this.message});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
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
      'data': data!.toJson(),
      'code': code,
      'message': message,
    };
  }
}

class Data {
  User user;
  Tokens tokens;

  Data({required this.user, required this.tokens});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tokens': tokens.toJson(),
    };
  }
}

class User {
  String id;
  String signupMeans;
  String email;
  bool disabled;
  String createdAt;
  String updatedAt;

  User({required this.id, required this.signupMeans, required this.email, required this.disabled, required this.createdAt, required this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      signupMeans: json['signup_means'],
      email: json['email'],
      disabled: json['disabled'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'signup_means': signupMeans,
      'email': email,
      'disabled': disabled,
      'created_at': createdAt,
      'updated_at': updatedAt,
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
