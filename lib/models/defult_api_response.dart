import 'dart:convert';

DefaultApiResponse defaultApiResponseFromJson(String str) => DefaultApiResponse.fromJson(json.decode(str));

String defaultApiResponseToJson(DefaultApiResponse data) => json.encode(data.toJson());

class DefaultApiResponse {
  DefaultApiResponse({
    required this.statusCode,
    required this.message,
  });

  int statusCode;
  String message;

  factory DefaultApiResponse.fromJson(Map<String, dynamic> json) => DefaultApiResponse(
    statusCode: json["statusCode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
  };
}