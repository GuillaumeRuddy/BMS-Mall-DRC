import 'dart:convert';

Driver? driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver? data) => json.encode(data!.toJson());

class Driver {
  Driver({
    this.id,
    this.marchandId,
    this.latitude,
    this.longitude,
  });

  int? id;
  int? marchandId;
  String? latitude;
  String? longitude;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
      id: json["id"],
      marchandId: json["marchand_id"],
      latitude: json["latitude"],
      longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "marchand_id": marchandId,
        "latitude": latitude,
        "longitude": longitude
      };
}
