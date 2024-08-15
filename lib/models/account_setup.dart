class AccountSetupModel{
  final Map<String, bool> data;

  AccountSetupModel({required this.data});

  factory AccountSetupModel.fromJson(Map<String, dynamic> json) {
    final data = Map<String, bool>.from(json['data']);
    return AccountSetupModel(data: data);
  }
}
