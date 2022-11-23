// To parse this JSON data, do
//
//     final fetchDataModel = fetchDataModelFromJson(jsonString);

import 'dart:convert';

List<FetchDataModel> fetchDataModelFromJson(String str) => List<FetchDataModel>.from(json.decode(str).map((x) => FetchDataModel.fromJson(x)));

String fetchDataModelToJson(List<FetchDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchDataModel {
    FetchDataModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    int? userId;
    int? id;
    String? title;
    String? body;

    factory FetchDataModel.fromJson(Map<String, dynamic> json) => FetchDataModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
