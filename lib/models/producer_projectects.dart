class AllProducerProjects {
  bool? error;
  bool? success;
  List<Data>? data;
  int? code;
  String? message;

  AllProducerProjects(
      {this.error, this.success, this.data, this.code, this.message});

  AllProducerProjects.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? sId;
  String? producerId;
  String? projectName;
  String? description;
  String? thumbnail;
  bool? published;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.sId,
      this.producerId,
      this.projectName,
      this.description,
      this.thumbnail,
      this.published,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    producerId = json['producer_id'];
    projectName = json['project_name'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['producer_id'] = this.producerId;
    data['project_name'] = this.projectName;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['published'] = this.published;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}




// class AllProducerProjects {
//   bool? error;
//   bool? success;
//   List<Data>? data;
//   int? code;
//   String? message;

//   AllProducerProjects(
//       {this.error, this.success, this.data, this.code, this.message});

//   AllProducerProjects.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     code = json['code'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['code'] = this.code;
//     data['message'] = this.message;
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   String? producerId;
//   String? projectName;
//   String? description;
//   String? thumbnail;
//   bool? published;
//   String? createdAt;
//   String? updatedAt;

//   Data(
//       {this.sId,
//       this.producerId,
//       this.projectName,
//       this.description,
//       this.thumbnail,
//       this.published,
//       this.createdAt,
//       this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     producerId = json['producer_id'];
//     projectName = json['project_name'];
//     description = json['description'];
//     thumbnail = json['thumbnail'];
//     published = json['published'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['producer_id'] = this.producerId;
//     data['project_name'] = this.projectName;
//     data['description'] = this.description;
//     data['thumbnail'] = this.thumbnail;
//     data['published'] = this.published;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }


// class AllProducerProjects {
//   String? sId;
//   String? producerId;
//   String? projectName;
//   String? description;
//   String? thumbnail;
//   bool? published;
//   String? createdAt;
//   String? updatedAt;

//   AllProducerProjects(
//       {this.sId,
//       this.producerId,
//       this.projectName,
//       this.description,
//       this.thumbnail,
//       this.published,
//       this.createdAt,
//       this.updatedAt});

//   AllProducerProjects.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     producerId = json['producer_id'];
//     projectName = json['project_name'];
//     description = json['description'];
//     thumbnail = json['thumbnail'];
//     published = json['published'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['producer_id'] = this.producerId;
//     data['project_name'] = this.projectName;
//     data['description'] = this.description;
//     data['thumbnail'] = this.thumbnail;
//     data['published'] = this.published;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
