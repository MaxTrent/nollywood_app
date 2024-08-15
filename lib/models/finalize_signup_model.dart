class FinalizeSignUpModel {
  final bool error;
  final bool success;
  final Data data;
  final int code;
  final String message;

  FinalizeSignUpModel({
    required this.error,
    required this.success,
    required this.data,
    required this.code,
    required this.message,
  });

  factory FinalizeSignUpModel.fromJson(Map<String, dynamic> json) {
    return FinalizeSignUpModel(
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
  final User user;
  final Tokens tokens;

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
  final String signupMeans;
  final String email;
  final bool disabled;
  final String id;
  final String createdAt;
  final String updatedAt;

  User({
    required this.signupMeans,
    required this.email,
    required this.disabled,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      signupMeans: json['signup_means'],
      email: json['email'],
      disabled: json['disabled'],
      id: json['_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signup_means': signupMeans,
      'email': email,
      'disabled': disabled,
      '_id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

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
