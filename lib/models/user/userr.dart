import 'package:json_annotation/json_annotation.dart';

part 'userr.g.dart';

@JsonSerializable()
class Userr {
    Userr({
      required this.id,
      required this.imageUrl,
      required this.points,
      required this.public,
      required this.rank,
      required this.rfidtag,
      required this.username,
      required this.name,
      required this.rfidpass,
    });

    String id;
    String imageUrl;
    int points;
    bool public;
    int rank;
    String rfidtag;   
    String username; 
    String name; 
    int rfidpass;


    factory Userr.fromJson(Map<String, dynamic> json) => _$UserrFromJson(json);
    Map<String, dynamic> toJson() => _$UserrToJson(this);
}
