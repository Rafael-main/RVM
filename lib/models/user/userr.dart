import 'package:json_annotation/json_annotation.dart';

part 'userr.g.dart';

@JsonSerializable()
class Userr {
    Userr({
      required this.id,
      required this.imageUrl,
      required this.points,
      required this.rank,
      required this.rfidtag,
      required this.username,
    });

    String id;
    String imageUrl;
    int points;
    String rank;
    String rfidtag;   
    String username; 


    factory Userr.fromJson(Map<String, dynamic> json) => _$UserrFromJson(json);
    Map<String, dynamic> toJson() => _$UserrToJson(this);
}
